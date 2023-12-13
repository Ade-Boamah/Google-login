import 'package:google_login/utils/utils.dart';

import 'core/app_export.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();

  // Note if you use this 👆🏿 method then you don't have to use "dispose"
  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool isvisible = true;
  bool canSee = true;

  Future userSignUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // if (_passwordController.text != _confirmPasswordController.text) {
    //   Navigator.pop(context);
    //   Utils.showSnackBar(context, "Password don't match");
    // } else {
    //   try {
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text,
    //       password: _passwordController.text,

    //       // pop the loading circle

    //       // ignore: use_build_context_synchronously
    //     );
    //   } on FirebaseAuthException catch (e) {
    //     // pop the loading circle

    //     // ignore: use_build_context_synchronously
    //     Navigator.pop(context);

    //     // show error message

    //     // ignore: use_build_context_synchronously
    //     Utils.showSnackBar(context, e.message);
    //   }
    //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // }
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: _passwordController.text,
        );
      }

      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // show error message

      // ignore: use_build_context_synchronously
      Utils.showSnackBar(context, e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _passwordController.dispose();

    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.w, 40.h, 30.w, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    size: 100.r,
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  MyTextFormField(
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? "Enter a valid email"
                            : null,
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  SizedBox(height: 10.h),
                  MyTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Enter a New Password";
                      } else if (value.length < 6) {
                        return "Password must be atleast 6 character long";
                      }
                      return null;
                    },
                    // (value) => value != null && value.length < 6
                    //     ? "Enter min. 6 characters"
                    //     : null,
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: isvisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isvisible = !isvisible;
                        });
                      },
                      icon: Icon(
                        isvisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  MyTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Re-Enter New Passwors";
                      } else if (value.length < 6) {
                        return "Password must be atleast 6 characters long";
                      } else if (value != _passwordController.text) {
                        return "Password must be the same as above";
                      }
                      return null;
                    },
                    // (value) => value != null && value.length < 6
                    //     ? "Enter min. 6 characters"
                    //     : null,
                    // labelText: "Comfirm Password",
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    obscureText: canSee,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          canSee = !canSee;
                        });
                      },
                      icon: Icon(
                        canSee ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  MyButton(
                    onTap: userSignUp,
                    text: "Sign Up",
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.r,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                        child: const Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.r,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        onTap: () =>
                            // signInWithGoogle(context),
                            signup(context),
                        imagePath: "images/google.png",
                      ),
                      SizedBox(
                        width: 20.h,
                      ),
                      SquareTile(
                        onTap: () {},
                        imagePath: "images/apple.png",
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      children: [
                        TextSpan(
                          text: "Login now",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onTap,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
