import 'core/app_export.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginOrRegister();
          }
          // if (snapshot.hasData) {
          //   // user is logged in
          //   return HomePage();
          // } else {
          //   // user is NOT logged in
          //   return const LoginOrRegister();
          // }
        },
      ),
    );
  }
}
