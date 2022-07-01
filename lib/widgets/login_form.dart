import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../miscellaneous/constants.dart';
import '../miscellaneous/validators.dart';
import '../routes/route_manager.dart';
import '../services/user_helper.dart';
import '../view_models/user_management_view_model.dart';
import 'app_progress_indicator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserManagementViewModel>().loginFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome to MyNotes!',
              style: headingStyle,
            ),
            const SizedBoxH30(),
            TextFormField(
              validator: validateEmail,
              controller: emailController,
              decoration: formDecoration('Email', Icons.mail),
            ),
            const SizedBoxH10(),
            TextFormField(
              obscureText: true,
              obscuringCharacter: '*',
              validator: validatePassword,
              controller: passwordController,
              decoration: formDecoration('Password', Icons.lock),
            ),
            const SizedBoxH20(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<UserManagementViewModel>().loginUserInUI(context,
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
              },
              child: const Text('Login'),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.of(context).pushNamed(RouteManager.registerPage);
                  },
                  child: const Text(
                    'Register',
                    style: style14Black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    resetPasswordInUI(context,
                        email: emailController.text.trim());
                  },
                  child: const Text(
                    'Reset Password',
                    style: style14Black,
                  ),
                ),
              ],
            ),
            const SizedBoxH10(),
            Selector<UserManagementViewModel, Tuple2>(
              selector: (context, value) =>
                  Tuple2(value.showUserProgress, value.userProgressText),
              builder: (context, value, child) {
                return value.item1
                    ? AppProgressIndicator(text: '${value.item2}')
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
