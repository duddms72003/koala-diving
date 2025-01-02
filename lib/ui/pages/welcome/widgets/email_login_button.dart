import 'package:flutter/material.dart';
import 'package:koala_diving/ui/pages/join/join_page.dart';
import 'package:koala_diving/ui/widgets/common_button.dart';

class EmailLoginButton extends StatelessWidget {
  const EmailLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          CommonButton(
            text: "이메일로 가입하기",
            backgroundColor: Color(0xFF0770E9),
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const JoinPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
