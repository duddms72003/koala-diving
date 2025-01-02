import 'package:flutter/material.dart';
import 'package:koala_diving/ui/widgets/common_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonButton(
            text: 'Google로 시작하기',
            icon: 'G',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: () {
              // Google 로그인 구현
            },
          ),
          const SizedBox(height: 10),
          CommonButton(
            text: 'Kakao로 시작하기',
            icon: 'K',
            backgroundColor: const Color(0xFFFEE500),
            textColor: Colors.black,
            onPressed: () {
              // Kakao 로그인 구현
            },
          ),
          const SizedBox(height: 10),
          CommonButton(
            text: 'Naver로 시작하기',
            icon: 'N',
            backgroundColor: const Color(0xFF03C75A),
            textColor: Colors.white,
            onPressed: () {
              // Naver 로그인 구현
            },
          ),
        ],
      ),
    );
  }
}
