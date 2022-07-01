import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(child: SingleChildScrollView(child: LoginForm())),
          ),
        ],
      ),
    );
  }
}
