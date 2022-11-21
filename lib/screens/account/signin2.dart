import 'package:flutter/material.dart';

class Signin2 extends StatelessWidget {
  Signin2({Key? key}) : super(key: key);
  final formGlobalKey = GlobalKey < FormState > ();
  final validName = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  final validNickname = RegExp('[A-Za-z][A-Za-z0-9_]{3,29}');
  TextEditingController nameInputController = TextEditingController();
  TextEditingController nicknameInputController = TextEditingController();
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
                const Padding(
                  padding: EdgeInsets.only(left: 20,top:40),
                  child: Text(
                      "거의 다 왔습니다.",
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.w300
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 5),
                  child: Text(
                      "조금만 힘내세요!",
                      style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.purple,
                          fontWeight: FontWeight.w300
                      ),
                      textAlign: TextAlign.left
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 50),
                  child: Text(
                      "닉네임",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return '입력칸을 채워주세요.';
                      }
                      if(!validNickname.hasMatch(nicknameInputController.text)){
                        return '잘못된 닉네임 형식입니다. 최소 4자리를 입력해주세요.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nickname',
                    ),
                    style: const TextStyle(fontSize: 15.0, height: 0.5, color: Colors.black),
                    controller: nicknameInputController,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 20),
                  child: Text(
                      "이름",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return '입력칸을 채워주세요.';
                      }
                      if(!validName.hasMatch(nameInputController.text)){
                        return '잘못된 이름 형식입니다.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Name',
                    ),
                    style: const TextStyle(fontSize: 15.0, height: 0.5, color: Colors.black),
                    controller: nameInputController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 50),
                  child: SizedBox(
                    width: 340, // <-- match_parent
                    height: 50, //
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.purple,
                      ),
                      onPressed: () {
                        if(formGlobalKey.currentState!.validate()) {
                          // 닉네임 이름 서버에 넘기고
                          // 화면 전환
                          Navigator.pushNamed(
                              context,
                              '/signin3'
                          );
                        }
                      },
                      child: const Text('계속하기'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}