import 'package:assignment2_2022/init.dart';
import 'package:flutter/material.dart';

import '../widgets/app_progress_indicator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    InitApp.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppProgressIndicator(
          text: 'Busy checking credentials...please wait...'),
    );
  }
}
