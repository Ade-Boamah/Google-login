// ignore_for_file: file_names

import '../core/app_export.dart';

class AppRoutes {
  static const String homepage = "/home_page";

  static const String forgotpasswordpage = "/forgot_password_page";

  static const String authpage = "/auth_page";

  static Map<String, WidgetBuilder> routes = {
    homepage: (context) => HomePage(),
    forgotpasswordpage: (context) => const ForgotPasswordPage(),
    authpage: (context) => const AuthPage(),
  };
}
