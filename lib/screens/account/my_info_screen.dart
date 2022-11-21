import 'package:dawu_start_from_homescreen/screens/account/my_info_setting_screen.dart';
import 'package:dawu_start_from_homescreen/screens/contest_list_screen.dart';
import 'package:dawu_start_from_homescreen/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/current_index.dart';
import '../../models/user_attribute.dart';
import '../../providers/user_attribute_api.dart';

class MyInfoScreen extends StatefulWidget {
  @override
  _MyInfoScreenState createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  UserAttribute? userAttribute;

  // API를 통해 변환
  // Dummy data for debugging
  late String myNickname = 'Nickname';
  late String myField = "머신러닝 프론트엔드";

  var myLabelList = List<String>.filled(5, 'a', growable: true);
  String totalContestNum = '10';
  var contestList = List<String>.filled(10, 'con', growable: true);
  var contestsLabelList = List<String>.filled(10, 'label', growable: true);
  var contestsLabelNumList = List<String>.filled(10, '1', growable: true);

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    UserAttribute? userAttribute = Provider.of<UserAttribute?>(context);

    userAttribute = UserAttributeApi.getUserAttribute();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '내 정보',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              // go to MyInfosetting
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => MyInfoSettingScreen())));
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
                padding: const EdgeInsets.only(
                    left: 50, top: 8, right: 8, bottom: 8),
                child: Text(
                  userAttribute!.name,
                  style: const TextStyle(
                      fontSize: 28.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ), //name
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, top: 8, right: 8, bottom: 8),
                child: Text(
                  DateFormat("yyyy/MM/dd").format(userAttribute.birthDate),
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ), //birth
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 50, top: 8, right: 8, bottom: 8),
            child: Text(
              userAttribute.email,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ), //email
          Row(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 8, right: 8, bottom: 8),
                child: Text(
                  '닉네임',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ), //'닉네임:'
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, top: 8, right: 8, bottom: 8),
                child: Text(
                  userAttribute.nickname,
                  style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ), //nickname
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 8, right: 8, bottom: 8),
                child: Text(
                  '분야',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ), //'분야:'
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 8, right: 8, bottom: 8),
              ),
              Chip(
                label: Text(userAttribute.field),
                labelPadding: const EdgeInsets.all(2.0),
                deleteIcon: const Icon(Icons.clear),
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
            padding: EdgeInsets.only(left: 30, top: 8, right: 8, bottom: 8),
            child: Text(
              '스펙',
              style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 30, top: 8, right: 8, bottom: 8),
                child: Text(
                  '참여 공모전 횟수',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ), //'분야:'
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, top: 8, right: 30, bottom: 8),
                child: Text(
                  '$totalContestNum개',
                  style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              //labels
            ],
          ),
          // 참여 공모전 리스트
          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.only(left: 70, top: 0, right: 8, bottom: 8),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Text(contestList[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 8, right: 8, bottom: 8),
            child: Text(
              '분야별 참여 횟수',
              style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
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
                      padding: const EdgeInsets.only(
                          left: 70, top: 0, right: 8, bottom: 0),
                      child: Text(
                        contestsLabelList[index],
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, top: 0, right: 30, bottom: 0),
                      child: Text(
                        '${contestsLabelNumList[index]}개',
                        style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ); //Text('Row $index');
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "공모전"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "내정보"),
        ],
        currentIndex: currentIndex.index,
        selectedItemColor: const Color(0xFF6667AB),
        onTap: ((value) {
          setState(() {
            currentIndex.setCurrentIndex(value);
            switch (currentIndex.index) {
              case 0:
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: ((context) {
                  return ContestListScreen();
                })));
                break;

              case 1:
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: ((context) {
                  return HomeScreen();
                })));
                break;

              case 2:
                break;
            }
          });
        }),
      ),
    );
  }
}
