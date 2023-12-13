import '../core/app_export.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;

  final String hintText;

  final bool obscureText;

  final String? Function(String?)? validator;

  final Widget? suffixIcon;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    this.suffixIcon,
  });
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.all(13.r),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }
}
