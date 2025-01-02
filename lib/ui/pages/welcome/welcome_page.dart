import 'package:flutter/material.dart';
import 'package:koala_diving/ui/pages/join/join_page.dart';
import 'package:koala_diving/ui/pages/login/login_page.dart';
import 'package:koala_diving/ui/pages/welcome/widgets/email_login_button.dart';
import 'package:koala_diving/ui/widgets/primary_button.dart';
import 'package:koala_diving/ui/pages/welcome/widgets/social_login_buttons.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/logo-black.png",
                  width: 160,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SocialLoginButtons(),
                  EmailLoginButton(),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "로그인하기",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "가입시 코다의 이용약관, 개인정보 처리방침, 쿠키사용에 동의하게 됩니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
