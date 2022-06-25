import 'package:flutter/material.dart';

import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/note_create_page.dart';
import '../pages/note_list_page.dart';
import '../pages/note_view_page.dart';
import '../pages/register_page.dart';

class RouteManager {
  static const String loadingPage = '/';
  static const String loginPage = '/loginPage';
  static const String registerPage = 'registerPage';
  static const String noteListPage = 'noteListPage';
  static const String noteViewPage = 'noteViewPage';
  static const String noteCreatePage = 'noteCreatePage';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const LoadingPage(),
        );

      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );

      case noteListPage:
        return MaterialPageRoute(
          builder: (context) => const NoteListPage(),
        );

      case noteViewPage:
        return MaterialPageRoute(
          builder: (context) => const NoteViewPage(),
        );

      case noteCreatePage:
        return MaterialPageRoute(
          builder: (context) => const NoteCreatePage(),
        );

      default:
        throw Exception('No route found');
    }
  }
}
