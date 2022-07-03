
import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../miscellaneous/constants.dart';
import '../view_models/note_view_model.dart';
import '../widgets/note_view.dart';

class NoteViewPage extends StatelessWidget {
  const NoteViewPage({
    Key? key, required this.note,
  }) : super(key: key);
    final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'View Note',
            style: whiteHeadingStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: provider.Consumer<NoteViewModel>(
            builder: (context, value, child) {
              return PageView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return NoteView(note: Note(title: note.title, message: note.message),);
                  });
            },
          ),
        ));
  }
}
