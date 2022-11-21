import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login1.dart';
import 'login2.dart';
import 'signin1.dart';
import 'signin2.dart';
import 'signin3.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named routes Demo',
    // "/"으로 named route와 함께 시작합니다. 본 예제에서는 FirstScreen 위젯에서 시작합니다.
    initialRoute: '/',
    routes: {
      '/': (context) => const Login1(),
      '/login1': (context) => const Login1(),
      '/login2': (context) => Login2(),
      '/signin1': (context) => Signin1(),
      '/signin2': (context) => Signin2(),
      '/signin3': (context) => Signin3(),
    },
  ));
}

class Login1 extends StatelessWidget {
  const Login1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 100),
            child: Text("팀원을 찾는 가장 쉬운 방법",
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.left),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text("SimpleTeamUp",
                style: TextStyle(
                    fontSize: 36.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.left),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 300),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
                backgroundColor: Colors.purple,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login2');
              },
              child: const Text('로그인'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signin1');
              },
              child: const Text(
                '가입하시겠습니까?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
