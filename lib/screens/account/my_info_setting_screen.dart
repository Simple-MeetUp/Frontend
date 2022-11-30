import 'package:dawu_start_from_homescreen/models/user_attribute.dart';
import 'package:dawu_start_from_homescreen/providers/user_attribute_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/field_list_api.dart';

class MyInfoSettingScreen extends StatefulWidget {
  @override
  _MyInfoSettingScreenState createState() => _MyInfoSettingScreenState();
}

class _MyInfoSettingScreenState extends State<MyInfoSettingScreen> {
  // 현재 서버에 저장된 분야 목록 -> 서버에서 가져와야 할 항목
  // 서버 연동 전까지는 Dummy data로 테스트
  List<String> existedApplyFieldItems = FieldListApi.getFieldList();

  var myLabelList = List<String>.filled(5, 'a', growable: true);
  String totalContestNum = '10';
  var contestList = List<String>.filled(10, 'con', growable: true);
  var contestsLabelList = List<String>.filled(10, 'label', growable: true);
  var contestsLabelNumList = List<String>.filled(10, '1', growable: true);
  TextEditingController nicknameEditController = TextEditingController();

  bool nicknameEditisEnable = true;
  bool fieldEditisEnable = true;

  @override
  Widget build(BuildContext context) {
    UserAttribute? userAttribute = Provider.of<UserAttribute?>(context);

    userAttribute ??= UserAttribute(
        email: "",
        nickname: "",
        name: "",
        field: "",
        gender: true,
        birthDate: DateTime(2022),
        joinedCount: 0,
        joinedContestList: []);

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
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              // make new attr instance
              UserAttributeApi.setUserAttribute(UserAttribute(
                  nickname: nicknameEditController.text,
                  email: userAttribute!.email,
                  name: userAttribute!.name,
                  field: userAttribute!.field,
                  gender: userAttribute!.gender,
                  birthDate: userAttribute!.birthDate,
                  // hazard. should be fixed.
                  joinedCount: 0,
                  joinedContestList: []));

              userAttribute = UserAttributeApi.getUserAttribute();
              // call api to apply updated attrs to userinfo

              // go to myinfo
              Navigator.of(context).pop();
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
                  DateFormat("yyyy/MM/dd").format(userAttribute!.birthDate),
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
              userAttribute!.email,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
          ), //email
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.052)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  controller: nicknameEditController,
                  enabled: nicknameEditisEnable,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (nicknameEditisEnable) {
                        nicknameEditisEnable = false;
                      } else {
                        nicknameEditisEnable = true;
                      }
                    });
                  })
            ],
          ),
          const Padding(padding: EdgeInsets.all(4)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 8, bottom: 8),
                child: Text(
                  '분야',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                  onPressed: (() {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          List<Text> fieldTextList = [];
                          List<Widget> widgetList = [
                            const Padding(padding: EdgeInsets.all(8))
                          ];

                          List<String> fieldList = FieldListApi.getFieldList();

                          for (String field in fieldList) {
                            fieldTextList.add(Text(
                              field,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ));
                          }

                          for (int i = 0; i < fieldList.length; i++) {
                            widgetList.add(fieldTextList[i]);
                            widgetList
                                .add(const Padding(padding: EdgeInsets.all(4)));
                          }

                          return SimpleDialog(
                            title: const Text("지원 가능한 분야 목록"),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: widgetList,
                              )
                            ],
                          );
                        }));
                  }),
                  icon: const Icon(
                    Icons.list_alt,
                    color: Colors.black26,
                    size: 32,
                  )), //'닉네임:'
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  enabled: fieldEditisEnable,
                  onChanged: (value) {
                    List<String> applyFieldItems =
                        value.split(' ').toSet().toList();

                    applyFieldItems.removeWhere((element) {
                      return !existedApplyFieldItems.contains(element);
                    });

                    userAttribute!.field = "";
                    for (int i = 0; i < applyFieldItems.length; i++) {
                      if (i == applyFieldItems.length - 1) {
                        userAttribute!.field += applyFieldItems[i];
                        break;
                      }
                      userAttribute!.field += "${applyFieldItems[i]} ";
                    }
                  },
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      if (fieldEditisEnable) {
                        fieldEditisEnable = false;
                      } else {
                        fieldEditisEnable = true;
                      }
                    });
                  })
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
      // bottomNavigationBar:
    );
  }
}
