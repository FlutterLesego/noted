// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/note_view_model.dart';
import '../view_models/user_management_view_model.dart';
import '../widgets/dialogs.dart';


void getNotesInUI(BuildContext context) async {
  String result = await context
      .read<NoteViewModel>()
      .getNotes(context.read<UserManagementViewModel>().currentUser!.email);
  if (result != 'OK') {
    showSnackBar(context, result);
  } else {
    showSnackBar(context, 'Notes retrived successfully!');
  }
}
