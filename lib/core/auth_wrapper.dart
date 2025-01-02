import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koala_diving/ui/pages/welcome/welcome_page.dart';
import 'package:koala_diving/ui/pages/home/home_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return WelcomePage();
          } else {
            return HomePage();
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}
