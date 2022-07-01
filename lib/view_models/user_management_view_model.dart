// ignore_for_file: body_might_complete_normally_nullable, prefer_is_empty, avoid_print, use_build_context_synchronously, unused_import, avoid_web_libraries_in_flutter

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/note_entry.dart';
import '../routes/route_manager.dart';
import '../widgets/dialogs.dart';
import 'note_view_model.dart';

class UserManagementViewModel with ChangeNotifier {
  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserToNull() {
    _currentUser = null;
  }

  //to check and show data in the UI if user exists/not
  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  //to show progress to the user with text
  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get userProgressText => _userProgressText;

  //creating a new user
  Future<String> createUserAccount(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating account...';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      NoteEntry emptyEntry = NoteEntry(notes: {}, username: user.email);
      await Backendless.data
          .of('NoteEntry')
          .save(emptyEntry.toJson())
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  //create a new user
  void createNewUserInUI(BuildContext context,
      {required String email,
      required String password,
      required String retypePassword}) async {
    if (registerFormKey.currentState?.validate() ?? false) {
      if (retypePassword.toString().trim() != password.toString().trim()) {
        showSnackBar(context, "passwords do not match!");
      }
      else{
      BackendlessUser user = BackendlessUser()
        ..email = email.trim()
        ..password = password.trim();

      String result =
          await context.read<UserManagementViewModel>().createUserAccount(user);
      if (result != 'OK') {
        showSnackBar(context, result);
      } else {
        showSnackBar(context, 'Account created successfully!');
        Navigator.pop(context);
      }}
    }
  }

  //check if the user already exists
  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.length == 0) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  //logging in the user
  Future<String> loginUser(String username, String password) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Logging in...';
    notifyListeners();
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    if (user != null) {
      _currentUser = user;
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  void loginUserInUI(BuildContext context,
      {required String email, required String password}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (loginFormKey.currentState?.validate() ?? false) {
      String result = await context
          .read<UserManagementViewModel>()
          .loginUser(email.trim(), password.trim());
      if (result != 'OK') {
        showSnackBar(context, result);
      } else {
        // get the user's notes
        context.read<NoteViewModel>().getNotes(email);
        Navigator.of(context).popAndPushNamed(RouteManager.noteListPage);
      }
    }
  }

  //check if the user is logged in and keep them logged in
  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';

    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (validLogin != null && validLogin) {
      String? currentUserObjectId = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      if (currentUserObjectId != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectId)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();
        } else {
          result = 'NOT OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  //logout the user from the app
  Future<String> logoutUser() async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Logging out...';
    notifyListeners();
    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  //reset user password
  Future<String> resetPassword(String username) async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Resetting password...';
    notifyListeners();
    await Backendless.userService
        .restorePassword(username)
        .onError((error, stackTrace) {
      result = getError(error.toString());
    });
    _showUserProgress = false;
    notifyListeners();
    return result;
  }
}

//error messages
String getError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please confirm your email address first';
  }
  if (message.contains('User already exists')) {
    return 'User already exists! Please create a new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'Invalid credentials! Please check your username or password.';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Account locked due to many failed login attempts. Please try again after 30 minutes.';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'Email address not found! Please check and try again.';
  }
  if (message.contains(
      'Unable to resolve host "api.backendless.com": No address associated with hostname')) {
    return 'No internet connection found! Please connect and try again.';
  }
  return message;
}
