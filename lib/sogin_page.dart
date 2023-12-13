import 'package:google_login/routes/app-routes.dart';
import 'package:google_login/utils/utils.dart';

import 'core/app_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool isvisible = true;

  Future userSignIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // showErrorMessage("😔 ${e.code}".toUpperCase());
      // ignore: use_build_context_synchronously
      Utils.showSnackBar(context, e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.w, 50.h, 30.w, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 100.r,
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "Welcome back you've been missed!",
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    MyTextFormField(
                      validator:
                       (email) {
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
                    SizedBox(height: 10.h),
                    MyTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          "Enter a password";
                        } else if (value.length < 6) {
                          return "Enter a min. 6 characters";
                        } else {
                          return null;
                        }
                        return null;
                      },
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: isvisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: Icon(isvisible
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.forgotpasswordpage,
                            );
                          },
                          child: const Text("Forgot Password?"),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    MyButton(
                      onTap: userSignIn,
                      text: "Sign In",
                    ),
                    SizedBox(height: 40.h),
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
                    SizedBox(height: 40.h),
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
                    SizedBox(height: 30.h),
                    RichText(
                      text: TextSpan(
                        text: "Not a member? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                        children: [
                          TextSpan(
                            text: "Register now",
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
      ),
    );
  }
}
