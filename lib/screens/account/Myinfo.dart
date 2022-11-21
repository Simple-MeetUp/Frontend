import 'package:flutter/material.dart';


class Myinfo extends StatelessWidget {
  Myinfo ({Key? key}) : super(key: key);
  // API를 통해
  String myName  = '홍길동';
  String myBirth = '2022/11/22';
  String myEmail = '32184140@dankook.ac.kr';
  String myNickname = 'Nickname';
  var myLabelList = List<String>.filled(5,'a', growable: true);
  String totalContestNum = '10';
  var contestList = List<String>.filled(10,'con', growable: true);
  var contestsLabelList = List<String>.filled(10,'label', growable: true);
  var contestsLabelNumList = List<String>.filled(10,'1', growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('내 정보',),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // go to myinfosetting
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
                child: Text(myName,
                  style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),//name
              Padding(
                padding: const EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
                child: Text(myBirth,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                  ),),
              ),//birth
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
            child: Text(myEmail,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300
              ),),
          ),//email
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
                child: Text('닉네임',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),),
              ),//'닉네임:'
              Padding(
                padding: const EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
                child: Text(myNickname,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300
                  ),),
              ),//nickname
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 50,top: 8,right: 8,bottom: 8),
                child: Text('분야',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),),
              ),//'분야:'
              Padding(
                padding: EdgeInsets.only(left: 30,top: 8,right: 8,bottom: 8),
                child: Chip(
                  label: Text("머신러닝"),
                  labelPadding: EdgeInsets.all(2.0),
                  deleteIcon: Icon(Icons.clear),
                ),
              ),
              Chip(
                label: Text("C++"),
                labelPadding: EdgeInsets.all(2.0),
                deleteIcon: Icon(Icons.clear),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 30,
            thickness: 1,
            indent: 1,
            endIndent: 1,
          ),
          const Padding(
            padding:  EdgeInsets.only(left: 30,top: 8,right: 8,bottom: 8),
            child: Text('스펙',
              style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 30,top: 8,right: 8,bottom: 8),
                child: Text('참여 공모전 횟수',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),),
              ),//'분야:'
              Padding(
                padding: const EdgeInsets.only(left: 8,top: 8,right: 30,bottom: 8),
                child: Text(totalContestNum+'개',
                  style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ),
              //labels
            ],
          ),
          // 참여 공모전 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 70,top: 0,right: 8,bottom: 8),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Text(contestList[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30,top: 8,right: 8,bottom: 8),
            child: Text('분야별 참여 횟수',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 70,top: 0,right: 8,bottom: 0),
                      child: Text(contestsLabelList[index],
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300
                        ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,top: 0,right: 30,bottom: 0),
                      child: Text(contestsLabelNumList[index]+'개',
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ],
                ); //Text('Row $index');
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}