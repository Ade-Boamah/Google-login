// ignore_for_file: use_build_context_synchronously

import 'package:google_login/utils/utils.dart';

import 'core/app_export.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Reset Password"),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 0.h, 30.w, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Receive an email to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.sp),
              ),
              SizedBox(height: 10.h),
              MyTextFormField(
                validator: (email) {
                  if (email!.isEmpty) {
                    return "Enter an email";
                  } else if (!EmailValidator.validate(email)) {
                    return "Enter a valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: resetPassword,
                icon: const Icon(Icons.mail_outline, color: Colors.white),
                label: const Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 22, 9, 46).withOpacity(0.5),
                  minimumSize: Size(double.maxFinite, 40.h),
                  shape: const BeveledRectangleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      Utils.showSnackBar(context, "Password Reset Email Sent");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      Utils.showSnackBar(context, e.message);
      Navigator.pop(context);
    }
  }
}
