import 'package:flutter/material.dart';
import '../miscellaneous/constants.dart';
import '../models/note.dart';

class NoteView extends StatelessWidget {
  const NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          note.title,
          style: titleStyle,
        ),
        const SizedBoxH10(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            note.message,
            style: style14Black,
          ),
        ),
      ],
    );
  }
}
