import 'package:flutter/material.dart';

import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register User'),
        ),
        body: Stack(
          children: const [
            Center(child: SingleChildScrollView(child: RegisterForm())),
          ],
        ));
  }
}
