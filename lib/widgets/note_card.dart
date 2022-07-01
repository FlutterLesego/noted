import 'package:flutter/material.dart';

import '../models/note.dart';
import '../routes/route_manager.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note}) : super(key: key);
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(note.title,
          style: const TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.w300,
            fontSize: 20)),
          onTap: (){
            Navigator.of(context).pushNamed(RouteManager.noteViewPage);
          },
        ),
      ),
    );
  }
}
