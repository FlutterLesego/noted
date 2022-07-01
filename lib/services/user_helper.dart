// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/route_manager.dart';
import '../view_models/user_management_view_model.dart';
import '../widgets/dialogs.dart';



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
