import 'package:flutter/material.dart';

import '../miscellaneous/constants.dart';
import '../widgets/note_form.dart';

class NoteCreatePage extends StatelessWidget {
  const NoteCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create a new note',
        style: whiteHeadingStyle,),
      ),
      body: Stack(
        children: const [
          Center(child: SingleChildScrollView(child: NoteForm())),
        ],
      ),
    );
  }
}
