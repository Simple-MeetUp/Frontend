import 'package:dawu_start_from_homescreen/screens/contest_register_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/field_list_api.dart';
import '../models/Contest.dart';
import '../models/current_index.dart';
import '../providers/contest_list_api.dart';
import 'home_screen.dart';

class ContestRegisterScreen extends StatefulWidget {
  @override
  _ContestRegisterScreenState createState() {
    return _ContestRegisterScreenState();
  }
}

class _ContestRegisterScreenState extends State<ContestRegisterScreen> {
  late Contest contest;
  late ContestInfo contestInfo;
  ContestListApi contestListApi = ContestListApi();

  // 무조건 build() 밖에 써준다.
  final ValueNotifier<String> alertTitleMessage = ValueNotifier<String>("");
  final ValueNotifier<String> alertDescMessage = ValueNotifier<String>("");
  final ValueNotifier<String> alertMessage = ValueNotifier<String>("");

  // TextField 값 컨트롤
  var minValController = TextEditingController();
  var maxValController = TextEditingController();

  // fields for Content instance to be created
  int? id; // PK. 1부터 시작
  String? thumbnail; // 미사용
  String? title;
  String? subtitle; // subtitle은 contestInfo.field와 같음
  String? description;
  int? minPeople;
  int? maxPeople;
  DateTime? activityStartPeriod;
  DateTime? activityDuePeriod;
  DateTime? registerStartPeriod;
  DateTime? registerDuePeriod;

  String? field = ""; // 분야. 공백 단위로 각 분야 구분.

  @override
  void initState() {
    super.initState();
  }

  Future<DateTime> _pickDateDialog(BuildContext context, int index) async {
    DateTime? pickedDate;

    // index list
    // 0 - activityStartPeriod
    // 1 - activityDuePeriod
    // 2 - registerStartPeriod
    // 3 - registerDuePeriod
    switch (index) {
      case 0:
        pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: activityDuePeriod ?? DateTime(DateTime.now().year + 1),
        );
        pickedDate ??= activityStartPeriod;

        setState(() {
          activityStartPeriod = pickedDate;
        });
        break;

      case 1:
        pickedDate = await showDatePicker(
          context: context,
          initialDate: activityStartPeriod ?? DateTime.now(),
          firstDate: activityStartPeriod ?? DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        pickedDate ??= activityDuePeriod;

        setState(() {
          activityDuePeriod = pickedDate;
        });
        break;

      case 2:
        pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: registerDuePeriod ?? DateTime(DateTime.now().year + 1),
        );
        pickedDate ??= registerStartPeriod;

        setState(() {
          registerStartPeriod = pickedDate;
        });
        break;

      case 3:
        pickedDate = await showDatePicker(
          context: context,
          initialDate: registerStartPeriod ?? DateTime.now(),
          firstDate: registerStartPeriod ?? DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        pickedDate ??= registerDuePeriod;

        setState(() {
          registerDuePeriod = pickedDate;
        });
        break;

      default:
    }

    return pickedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
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

    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);

    contest = ContestListApi.getContest(0); // temp. to be deleted

    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("공모전 등록",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6667AB),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
          child: Column(children: [
            Row(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "주제",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  // alertMessage 값이 외부에서 바뀌면 해당 값을 사용하는 다른 위젯도 바뀜
                  child: ValueListenableBuilder(
                    valueListenable: alertTitleMessage,
                    builder: (context, value, child) {
                      return Text(value,
                          style: const TextStyle(
                              fontSize: 14, color: Color(0xFFFF3053)));
                    },
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(left: 10, top: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: TextField(
                    onChanged: (value) {
                      if (value == "") {
                        alertTitleMessage.value = "주제를 입력해 주세요.";
                        return;
                      } else {
                        alertTitleMessage.value = "";
                      }

                      setState(() {
                        title = value;
                      });
                    },
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "입력 예시) 프로그래밍 경진대회",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide:
                            BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide:
                            BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide:
                            BorderSide(width: 1.4, color: Color(0x0F6A6B92)),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6667AB)),
                    onPressed: (() {
                      // 화면에서 입력받은 값 확인하기
                      if ([
                        // id,
                        // thumbnail, -> 이미지 주소인데 안 쓰기로 함
                        title,
                        subtitle,
                        description,
                        minPeople,
                        maxPeople,
                        activityStartPeriod,
                        activityDuePeriod,
                        registerStartPeriod,
                        registerDuePeriod
                      ].any((element) => element == null)) {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text("등록하기"),
                                content: const Text("모든 항목을 입력해 주세요."),
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

                      // 입력받은 값들을 Contest, ContestInfo에 넣어 객체 생성하기
                      contestInfo = ContestInfo(
                          description: description ?? "",
                          field: field ?? "",
                          minPeople: minPeople ?? 0,
                          maxPeople: maxPeople ?? 0,
                          activityStartPeriod:
                              activityStartPeriod ?? DateTime.now(),
                          activityDuePeriod:
                              activityDuePeriod ?? DateTime.now(),
                          registerStartPeriod:
                              registerStartPeriod ?? DateTime.now(),
                          registerDuePeriod:
                              registerDuePeriod ?? DateTime.now());
                      contest = Contest(
                          id: id ?? ContestListApi.getContestListCount() + 1,
                          thumbnail: thumbnail ??
                              "https://images.hdqwalls.com/download/windows-xp-bliss-4k-lu-1280x800.jpg",
                          title: title ?? "",
                          subtitle: subtitle ?? "",
                          contestInfo: contestInfo);

                      //
                      // TO DO : Contest, ContestInfo 객체를 API 호출로 넘기기
                      //
                      ContestListApi.addContest(contest);

                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text("등록하기"),
                              content: const Text("모든 항목을 입력하셨습니다."),
                              actions: [
                                TextButton(
                                    onPressed: (() {
                                      Navigator.pop(context);

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: ((context) {
                                        return ContestRegisterCompleteScreen();
                                      })));
                                    }),
                                    child: const Text("확인"))
                              ],
                            );
                          }));
                    }),
                    child: const Text("등록하기",
                        style: TextStyle(
                          fontSize: 15,
                        )))
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Text(
                    "내용",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    // alertMessage 값이 외부에서 바뀌면 해당 값을 사용하는 다른 위젯도 바뀜
                    child: ValueListenableBuilder(
                      valueListenable: alertDescMessage,
                      builder: (context, value, child) {
                        return Text(value,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xFFFF3053)));
                      },
                    ),
                  )
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(4)),
            SizedBox(
              child: TextField(
                onChanged: (value) {
                  if (value == "") {
                    alertDescMessage.value = "내용을 입력해 주세요.";
                  } else {
                    alertDescMessage.value = "";
                  }
                  description = value;
                },
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "입력 예시) 북한산 정보 관련 앱 서비스 개발",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0x0F6A6B92)),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Text(
                      "관련 분야",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                  title: const Text("등록 가능한 분야 목록"),
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
                        )),
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
                    )
                  ],
                )),
            const Padding(padding: EdgeInsets.all(4)),
            SizedBox(
              child: TextField(
                onChanged: (value) {
                  field = value;

                  String applyField = field ?? "";
                  subtitle = applyField;

                  List<String> applyFieldItems = applyField.split(' ');

                  bool isExistedWrongField = false; // 잘못된 분야를 찾으면 true

                  // validation
                  for (int i = 0; i < applyFieldItems.length; i++) {
                    if (isExistedWrongField) {
                      break;
                    }
                    for (int j = 0; j < existedApplyFieldItems.length; j++) {
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
                  // if (duplicateFieldItems.isNotEmpty) {
                  //   alertMessage.value += " (";
                  //   for (int i = 0; i < duplicateFieldItems.length; i++) {
                  //     if (i == duplicateFieldItems.length - 1) {
                  //       alertMessage.value += duplicateFieldItems[i];
                  //     } else {
                  //       alertMessage.value += "${duplicateFieldItems[i]}, ";
                  //     }
                  //   }
                  //   alertMessage.value += ")";
                  // }
                },
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "입력 예시) 백엔드 머신러닝 프론트엔드",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0xFF6667AB)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    borderSide:
                        BorderSide(width: 1.4, color: Color(0x0F6A6B92)),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(16)),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "모집 인원",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "최소",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: TextField(
                        controller: minValController,
                        onChanged: (value) {
                          minPeople = int.parse(value);
                          if (minPeople! > maxPeople!) {
                            minPeople = maxPeople;
                            minValController.text = maxPeople.toString();
                          }
                        },
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0xFF6667AB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0xFF6667AB)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0x0F6A6B92)),
                          ),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "최대",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                      height: MediaQuery.of(context).size.width * 0.12,
                      child: TextField(
                        controller: maxValController,
                        onChanged: (value) {
                          maxPeople = int.parse(value);
                          if (minPeople! > maxPeople!) {
                            maxPeople = minPeople;
                            maxValController.text = minPeople.toString();
                          }
                        },
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0xFF6667AB)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0xFF6667AB)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            borderSide: BorderSide(
                                width: 1.4, color: Color(0x0F6A6B92)),
                          ),
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16)),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "활동 기간",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (() {
                            setState(() async {
                              activityStartPeriod =
                                  await _pickDateDialog(context, 0);
                            });
                          }),
                          child: Text(
                            activityStartPeriod != null
                                ? DateFormat("yyyy-MM-dd").format(
                                    activityStartPeriod ?? DateTime.now())
                                : "탭하여 설정하기",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(left: 4)),
                const Text("~"),
                const Padding(padding: EdgeInsets.only(left: 4)),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (() {
                            setState(() async {
                              activityDuePeriod =
                                  await _pickDateDialog(context, 1);
                            });
                          }),
                          child: Text(
                            activityDuePeriod != null
                                ? DateFormat("yyyy-MM-dd")
                                    .format(activityDuePeriod ?? DateTime.now())
                                : "탭하여 설정하기",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const Padding(padding: EdgeInsets.all(12)),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "신청 기간",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 20)),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (() {
                            setState(() async {
                              registerStartPeriod =
                                  await _pickDateDialog(context, 2);
                            });
                          }),
                          child: Text(
                            registerStartPeriod != null
                                ? DateFormat("yyyy-MM-dd").format(
                                    registerStartPeriod ?? DateTime.now())
                                : "탭하여 설정하기",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                const Padding(padding: EdgeInsets.only(left: 4)),
                const Text("~"),
                const Padding(padding: EdgeInsets.only(left: 4)),
                SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (() {
                            setState(() async {
                              registerDuePeriod =
                                  await _pickDateDialog(context, 3);
                            });
                          }),
                          child: Text(
                            registerDuePeriod != null
                                ? DateFormat("yyyy-MM-dd")
                                    .format(registerDuePeriod ?? DateTime.now())
                                : "탭하여 설정하기",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "공모전"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "내정보"),
        ],
        selectedItemColor: const Color(0xFF6667AB),
        onTap: ((value) {
          setState(() {
            currentIndex.setCurrentIndex(value);
            switch (currentIndex.index) {
              case 0:
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
