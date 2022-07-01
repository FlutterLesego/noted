import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),),
    backgroundColor: Colors.black,
    duration: const Duration(milliseconds: 3000),
    content: Text(message,
    textAlign: TextAlign.center,),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
