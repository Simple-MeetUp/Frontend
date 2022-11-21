import 'package:flutter/material.dart';

class ContestRegisterCompleteScreen extends StatelessWidget {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // disable back button on this screen
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(90)),
          Container(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("등록완료",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6667AB))),
                  Padding(padding: EdgeInsets.all(5)),
                  Text("수고하셨습니다.",
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6667AB))),
                ],
              )),
          Container(
            height: MediaQuery.of(context).size.height * 0.54,
          ),
          ElevatedButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                    MediaQuery.of(context).size.height * 0.05),
                backgroundColor: const Color(0xFF6667AB)),
            child: const Text("등록완료",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ]),
      )),
    );
  }
}
