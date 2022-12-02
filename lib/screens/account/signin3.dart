import 'package:dawu_start_from_homescreen/providers/user_auth_info_api.dart';
import 'package:dawu_start_from_homescreen/screens/home_screen.dart';
import 'package:flutter/material.dart';


import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:dawu_start_from_homescreen/http/request.dart';
import 'package:dawu_start_from_homescreen/providers/user_attribute_api.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';

class Signin3 extends StatefulWidget {
  @override
  Signin3_2 createState() => Signin3_2();
}

class Signin3_2 extends State<Signin3> {
  bool isSwitched = false;
  String gender_to_string(bool gender) {
    return gender ? "MALE" : "FEMALE";
  }
  final formGlobalKey = GlobalKey<FormState>();
  final validBirth =
      RegExp('[0-9]{4}-(1[0-2]|0[1-9])-(3[01]|[12][0-9]|0[1-9])');
  TextEditingController birthInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: formGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 40),
              child: Text("이제 마지막 입니다.",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: defaultColor,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: Text("수고하셨습니다!",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: defaultColor,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 50),
              child: Text("성별",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                  textAlign: TextAlign.left),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 130, top: 20),
                  child: Text("여자",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Switch(
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.blue,
                      inactiveThumbColor: Colors.red,
                      inactiveTrackColor: Colors.red,
                      value: isSwitched,
                      onChanged: (value) => setState(() => isSwitched = value)),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 0, top: 20),
                  child: Text("남자",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text("생년월일",
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
                  if (!validBirth.hasMatch(birthInputController.text)) {
                    return '생년월일을 정확히 기입해주세요.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: '입력형식 : 2022-11-22',
                ),
                controller: birthInputController,
                style: const TextStyle(
                    fontSize: 15.0, height: 0.5, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 50),
              child: SizedBox(
                width: 340, // <-- match_parent
                height: 50, //
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    backgroundColor: defaultColor,
                  ),
                  onPressed: () async{
                    // 성별, 생년월일 전달 후
                    UserAttributeApi.resetGender(isSwitched);
                    UserAttributeApi.resetBirthdate(DateTime.parse(birthInputController.text));
                    // 서버에 signin 요청 후
                    SignUpRequest signupRequest = SignUpRequest(
                      birthday: DateFormat('yyyy-MM-dd').format(UserAttributeApi.userAttribute!.birthDate),
                      email: UserAuthInfoApi.userAuthInfo?.email,
                      gender: gender_to_string(UserAttributeApi.userAttribute!.gender),
                      name: UserAttributeApi.userAttribute?.name,
                      nickname: UserAttributeApi.userAttribute?.nickname,
                      password: UserAuthInfoApi.userAuthInfo?.password,
                    );
                    String url = baseUrl + 'user/signup';

                    UserResponse userResponse = await SignUp(url, signupRequest);

                    // home으로 이동
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => HomeScreen())));
                  },
                  child: const Text('계속하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
