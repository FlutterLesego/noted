// ignore_for_file: prefer_is_empty, use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:assignment2_2022/models/note_entry.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../widgets/dialogs.dart';

class NoteViewModel with ChangeNotifier {
  final noteFormKey = GlobalKey<FormState>();

  NoteEntry? _noteEntry;

//get the list of notes
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
  Future<String> getNotes(String email) async {
    String result = 'OK';
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$email'";

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
    await Backendless.data.of('NoteEntry').find(dataQueryBuilder);
    return result;
  }

  Future<String> saveNote(String email, bool inUI) async {
    String result = 'OK';
    if (_noteEntry == null) {
      _noteEntry = NoteEntry(notes: convertNoteListToMap(_notes), email: email);
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

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }

  void createNoteInUI(BuildContext context,
      {required TextEditingController titleController,
      required TextEditingController messageController}) async {
    if (noteFormKey.currentState?.validate() ?? false) {
      String result = await context.read<NoteViewModel>().saveNote(
          context.read<UserManagementViewModel>().currentUser!.email, true);
      if (result != 'OK') {
        showSnackBar(context, result);
      } else {
        Note note = Note(
          email: context
              .read<UserManagementViewModel>()
              .currentUser!
              .email
              .toString()
              .trim(),
          title: titleController.text.trim(),
          message: messageController.text.trim(),
        );
        if (context.read<NoteViewModel>().notes.contains(note)) {
          showSnackBar(context, 'Note with the same title already exists!');
        } else {
          context
              .read<UserManagementViewModel>()
              .currentUser!
              .email
              .toString()
              .trim();
          titleController.text = '';
          messageController.text = '';
          context.read<NoteViewModel>().createNote(note);
          Navigator.pop(context);
        }
      }
    }
  }

  void saveNoteInUI(BuildContext context) async {
    String result = await context.read<NoteViewModel>().saveNote(
        context.read<UserManagementViewModel>().currentUser!.email, true);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, "Note saved successfully!");
    }
  }

  void getNotesInUI(BuildContext context) async {
    String result = await context
        .read<NoteViewModel>()
        .getNotes(context.read<UserManagementViewModel>().currentUser!.email);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, "Notes retrieved successfully!");
    }
  }
}
