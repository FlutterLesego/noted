
// ignore_for_file: use_build_context_synchronously

import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/view_models/user_management_view_model.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static const String apiKeyAndroid =
      '34001CA4-E43DE-44B60-94677-342EFCF38782'; //add your own key
  static const String apiKeyIOS =
      'FB4C825E8-B4F01-48752-8B548-3ADF87659663'; //add your own key
  static const String appID =
      '5D0957284-F282D-FAC84-FF8BB-5489CB2C83100'; // add your own key

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
    String result =
        await context.read<UserManagementViewModel>().checkIfUserLoggedIn();
    if (result == 'OK') {
      Navigator.popAndPushNamed(context, RouteManager.noteListPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
