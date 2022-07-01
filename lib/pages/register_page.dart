import 'package:flutter/material.dart';

import '../miscellaneous/constants.dart';
import '../widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Create account',
          style: whiteHeadingStyle,),
        ),
        body: Stack(
          children: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(child: SingleChildScrollView(child: RegisterForm())),
            ),
          ],
        ));
  }
}
