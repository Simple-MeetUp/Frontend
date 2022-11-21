import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/screens/account/signin1.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey<FormState>();
  final validPW =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  final validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController emailInputController = TextEditingController();
  TextEditingController PWInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("팀원이 기다리고 있어요!",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: defaultColor,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("이메일",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '입력칸을 채워주세요.';
                  }
                  if (!validEmail.hasMatch(emailInputController.text)) {
                    return '이메일 양식이 잘못되었습니다.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: defaultColor, width: 20.0)
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'email'),
                style: const TextStyle(
                    fontSize: 15.0, height: 0.5, color: Colors.black),
                controller: emailInputController,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text("비밀번호",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '입력칸을 채워주세요.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'password',
                ),
                style: const TextStyle(
                    fontSize: 15.0, height: 0.5, color: Colors.black),
                controller: PWInputController,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: defaultColor,
                  minimumSize: Size(350, 50),
                ),
                onPressed: () {
                  if (validEmail.hasMatch(emailInputController.text)) {
                    if (validPW.hasMatch(PWInputController.text)) {
                      if (formGlobalKey.currentState!.validate()) {
                        // 아이디 비번이 맞으면 로그인 성공, home으로 이동
                        // 틀리면 error 문구 출력
                      }
                    }
                  }
                },
                child: const Text('로그인'),
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => Signin1())));
                },
                child: const Text(
                  '가입하시겠습니까?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: defaultColor
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
