import 'package:dawu_start_from_homescreen/providers/field_list_api.dart';
import 'package:dawu_start_from_homescreen/screens/components/showing_spec_tile.dart';
import 'package:dawu_start_from_homescreen/screens/contest_apply_complete_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ContestApplyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContestApplyScreenState();
  }
}

class _ContestApplyScreenState extends State<ContestApplyScreen> {
  // 무조건 build() 밖에 써준다.
  final ValueNotifier<String> alertMessage = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    String applyField = ""; // 분야 Form 필드에 입력된 문자열
    List<String> applyFieldItems = [];

    // 현재 서버에 저장된 분야 목록 -> 서버에서 가져와야 할 항목
    // 서버 연동 전까지는 Dummy data로 테스트
    List<String> existedApplyFieldItems = FieldListApi.getFieldList();
    const int OK = 0;
    const int WRONG = 1;
    const int DUPLICATED = 2;
    const List<String> alertMessageList = [
      "",
      "알맞은 분야를 작성해주세요.",
      "중복되는 분야가 있습니다."
    ];

    // 사용자의 스펙 목록 -> 서버에서 가져와야 할 항목
    // 서버 연동 전까지는 Dummy data로 테스트
    List<String> userSpecItemList = [
      "단국대-다우기술 대학생 프로그래밍 경진대회",
      "단국대 코딩콘테스트",
      "단국대 경소톤",
      "단국대 데이터 분석",
      "단국대 게임 개발 대회"
    ];

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(90)),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text("참가신청",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: defaultColor)),
              ),
              const Padding(padding: EdgeInsets.all(30)),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("지원 분야",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: (() {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  List<Text> fieldTextList = [];
                                  List<Widget> widgetList = [
                                    const Padding(padding: EdgeInsets.all(8))
                                  ];

                                  List<String> fieldList =
                                      FieldListApi.getFieldList();

                                  for (String field in fieldList) {
                                    fieldTextList.add(Text(
                                      field,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ));
                                  }

                                  for (int i = 0; i < fieldList.length; i++) {
                                    widgetList.add(fieldTextList[i]);
                                    widgetList.add(const Padding(
                                        padding: EdgeInsets.all(4)));
                                  }

                                  return SimpleDialog(
                                    title: const Text("지원 가능한 분야 목록"),
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                          ))
                    ],
                  )),
              const Padding(padding: EdgeInsets.all(8)),
              SizedBox(
                child: TextField(
                  onChanged: (value) {
                    if (value == "") {
                      alertMessage.value = alertMessageList[WRONG];
                      return;
                    }

                    bool isExistedWrongField = false; // 잘못된 분야를 찾으면 true

                    setState(() {
                      applyField = value;
                      applyFieldItems = applyField.split(' ');

                      // validation
                      for (int i = 0; i < applyFieldItems.length; i++) {
                        if (isExistedWrongField) {
                          break;
                        }
                        for (int j = 0;
                            j < existedApplyFieldItems.length;
                            j++) {
                          if (applyFieldItems[i] == existedApplyFieldItems[j]) {
                            break;
                          } else {
                            if (j == existedApplyFieldItems.length - 1) {
                              isExistedWrongField = true;
                            }
                          }
                        }
                      }
                      if (!isExistedWrongField) {
                        alertMessage.value =
                            alertMessageList[OK]; // 문제가 없다면 중복 확인으로 넘어감
                      } else {
                        alertMessage.value = alertMessageList[WRONG];
                        return;
                      }

                      // 중복된 분야가 있는지 확인
                      late String targetFieldItem;
                      List<String> duplicateFieldItems = [];

                      for (int i = 0; i < applyFieldItems.length; i++) {
                        targetFieldItem = applyFieldItems[i];
                        for (int j = i + 1; j < applyFieldItems.length; j++) {
                          if (j > i) {
                            if (targetFieldItem == applyFieldItems[j]) {
                              duplicateFieldItems.add(targetFieldItem);
                              alertMessage.value = alertMessageList[DUPLICATED];
                              break;
                            }
                          }
                        }
                      }

                      var seen = <String>{};
                      duplicateFieldItems = duplicateFieldItems
                          .where((item) => seen.add(item))
                          .toList();

                      // 중복되는 항목을 오류 메시지에 포함하기
                      if (duplicateFieldItems.isNotEmpty) {
                        alertMessage.value += " (";
                        for (int i = 0; i < duplicateFieldItems.length; i++) {
                          if (i == duplicateFieldItems.length - 1) {
                            alertMessage.value += duplicateFieldItems[i];
                          } else {
                            alertMessage.value += "${duplicateFieldItems[i]}, ";
                          }
                        }
                        alertMessage.value += ")";
                      }
                    });
                  },
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: "입력 예시) 모바일앱 백엔드",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      borderSide: BorderSide(width: 1.4, color: defaultColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      borderSide: BorderSide(width: 1.4, color: defaultColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      borderSide:
                          BorderSide(width: 1.4, color: Color(0x0F6A6B92)),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                // alertMessage 값이 외부에서 바뀌면 해당 값을 사용하는 다른 위젯도 바뀜
                child: ValueListenableBuilder(
                  valueListenable: alertMessage,
                  builder: (context, value, child) {
                    return Text(value,
                        style: const TextStyle(
                            fontSize: 14, color: Color(0xFFFF3053)));
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text("공개 스펙 설정",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: userSpecItemList.length,
                    itemBuilder: ((context, index) {
                      return ShowingSpecTile(specName: userSpecItemList[index]);
                    })),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                onPressed: (() {
                  if (alertMessage.value != alertMessageList[OK]) {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text("참가신청"),
                            content: const Text("지원분야 항목을 다시 확인해주세요."),
                            actions: [
                              TextButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: const Text("확인"))
                            ],
                          );
                        }));
                    return;
                  }

                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: ((context) {
                    return ContestApplyCompleteScreen();
                  })));
                }),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.8,
                        MediaQuery.of(context).size.height * 0.05),
                    backgroundColor: defaultColor),
                child: const Text("신청완료",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          )),
    );
  }
}
