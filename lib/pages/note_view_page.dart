
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../miscellaneous/constants.dart';
import '../view_models/note_view_model.dart';
import '../widgets/note_view.dart';

class NoteViewPage extends StatelessWidget {
  const NoteViewPage({
    Key? key,
  }) : super(key: key);

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
              return ListView.builder(
                itemCount: 1,
                  itemBuilder: (context, index) {
                    return NoteView(note: value.notes[index]);
                  });
            },
          ),
        ));
  }
}
