import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koala_diving/core/auth_service.dart';
import 'package:koala_diving/ui/pages/login/login_page.dart';
import 'package:koala_diving/ui/pages/welcome/welcome_page.dart'; // LoginPage import

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '환경 설정',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(240, 240, 240, 1),
            width: 1,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('로그아웃'),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              // 로그아웃 확인 다이얼로그
              final bool? logout = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('로그아웃'),
                    content: Text('정말 로그아웃 하시겠습니까?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('취소'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('확인'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  );
                },
              );

              if (logout == true) {
                await authService.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                  (Route<dynamic> route) => false,
                );
              }
            },
          ),
          // 여기에 다른 설정 옵션들을 추가할 수 있습니다.
        ],
      ),
    );
  }
}
