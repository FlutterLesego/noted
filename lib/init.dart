// ignore_for_file: use_build_context_synchronously
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'routes/route_manager.dart';
import 'view_models/note_view_model.dart';
import 'view_models/user_management_view_model.dart';

class InitApp {
  static const String apiKeyAndroid =
      '3BDAC8E9-6FA9-4842-836A-CA0FDB84D19C'; //add your own key
  static const String apiKeyIOS =
      'A21A191A-7E38-4F4E-922F-48B03500241D'; //add your own key
  static const String appID =
      '79E54C85-0790-7BCE-FF89-D5A14FC1C100'; // add your own key

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
    String result =
        await context.read<UserManagementViewModel>().checkIfUserLoggedIn();
    if (result == 'OK') {
      
      context.read<NoteViewModel>().getNotesInUI(context);
      //get the notes list for the specific user logged in
      context
          .read<NoteViewModel>()
          .getNotes(context.read<UserManagementViewModel>().currentUser!.email);
      Navigator.popAndPushNamed(context, RouteManager.noteListPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
