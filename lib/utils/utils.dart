import 'package:google_login/core/app_export.dart';

class Utils {
  static showSnackBar(BuildContext context, String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28.r),
        borderSide: BorderSide.none,
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
