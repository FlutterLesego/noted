// ignore_for_file: unnecessary_null_comparison, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import '../miscellaneous/constants.dart';
import '../routes/route_manager.dart';
import '../view_models/note_view_model.dart';
import '../view_models/user_management_view_model.dart';
import '../widgets/note_card.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.read<UserManagementViewModel>().logoutUserInUI(context);
          },
          icon: const Icon(Icons.logout_outlined),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'MyNotes',
          style: whiteHeadingStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: provider.Consumer<NoteViewModel>(
          builder: (context, value, child) {
            return value == null
                ? const Text(
                    'No notes to display',
                    style: style14Black,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(5.0),
                    itemCount: value.notes.length,
                    itemBuilder: (context, index) {
                      return NoteCard(note: value.notes[index]);
                    });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed(RouteManager.noteCreatePage);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
