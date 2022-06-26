// ignore_for_file: use_build_context_synchronously

import 'package:assignment2_2022/view_models/note_view_model.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/route_manager.dart';
import '../widgets/dialogs.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String retypePassword}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || password.isEmpty || retypePassword.isEmpty) {
    showSnackBar(
      context,
      'All fields required!',
    );
  } else if (retypePassword.toString() != password.toString()) {
    showSnackBar(context, "Passwords do not match!");
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim()
      ..putProperties({
        'email': email.trim(),
        'password': password.trim(),
      });

    String result =
        await context.read<UserManagementViewModel>().createUserAccount(user);
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      showSnackBar(context, 'Account created successfully!');
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackBar(context, 'All fields are required!');
  } else {
    String result = await context
        .read<UserManagementViewModel>()
        .loginUser(email.trim(), password.trim());
    if (result != 'OK') {
      showSnackBar(context, result);
    } else {
      //get the user's notes
      // context.read<NoteViewModel>().getNotes(email);
      Navigator.of(context).popAndPushNamed(RouteManager.noteListPage);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserManagementViewModel>().logoutUser();
  if (result == 'OK') {
    context.read<UserManagementViewModel>().setCurrentUserToNull();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackBar(context, result);
  }
}

//reset user password
void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackBar(context,
        'Please enter your email address and click on "Reset Password"');
  } else {
    String result = await context
        .read<UserManagementViewModel>()
        .resetPassword(email.trim());
    if (result == 'OK') {
      showSnackBar(context, 'Reset instructions sent to ${'email'}');
    } else {
      showSnackBar(context, result);
    }
  }
}
