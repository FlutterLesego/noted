// ignore_for_file: prefer_is_empty

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../models/note_entry.dart';
import '../widgets/dialogs.dart';

class NoteViewModel with ChangeNotifier {
  final noteFormKey = GlobalKey<FormState>();

  NoteEntry? _noteEntry;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void emptyNotes() {
    _notes = [];
    notifyListeners();
  }

  bool _retrievingNote = false;
  bool _savingNote = false;

  bool get retrievingNote => _retrievingNote;
  bool get savingNote => _savingNote;

  //retieve notes for a specific user
  Future<String> getNotes(String username) async {
    String result = 'OK';
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

      //show retrieval progress
    _retrievingNote = true;
    notifyListeners();

    //get data back from Note Entry table
    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('NoteEntry')
        .find(dataQueryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
    });

    //checking if the note retireval resulted in an error
    if (result != 'OK') {
      _retrievingNote = false;
      notifyListeners();
      return result;
    }

    //get a note entry if there is one
    if (map != null) {
      if (map.length > 0) {
        _noteEntry = NoteEntry.fromJson(map.first);
        _notes = convertMapToNoteList(_noteEntry!.notes);
        notifyListeners();
      } else {
        emptyNotes();
      }
    } else {
      result = 'NOT OK';
    }

    //stop the retrieval progress
    _retrievingNote = false;
    notifyListeners();
    // await Backendless.data.of('NoteEntry').find(dataQueryBuilder);
    return result;
  }

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void createNoteInUI(BuildContext context,
    {required TextEditingController titleController,
    required TextEditingController messageController}) async {
  if (noteFormKey.currentState?.validate()?? false) {
    Note note = Note(
      title: titleController.text.trim(),
      message: messageController.text.trim(),
    );
      
      titleController.text = '';
      messageController.text = '';
      context.read<NoteViewModel>().createNote(note);
      Navigator.pop(context);
  }
}

  Future<String> saveNoteEntry(String username, bool inUI) async {
    String result = 'OK';
    if (_noteEntry == null) {
      _noteEntry =
          NoteEntry(notes: convertNoteListToMap(_notes), username: username);
    } else {
      _noteEntry!.notes = convertNoteListToMap(_notes);
    }

    if (inUI) {
      _savingNote = true;
      notifyListeners();
    }
    await Backendless.data
        .of('NoteEntry')
        .save(_noteEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
    });
    if (inUI) {
      _savingNote = false;
      notifyListeners();
    }

    return result;
  }
}
