import 'dart:async';

import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/request.dart';
import 'package:dawu_start_from_homescreen/models/is_browsed.dart';
import 'package:dawu_start_from_homescreen/screens/account/my_info_screen.dart';
import 'package:dawu_start_from_homescreen/screens/contest_list_screen.dart';
import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http/dto.dart';
import '../models/user_id.dart';
import 'components/contest_tile.dart';

// 남은 할 일
// 1. 참가신청
// 2. 참가신청 수락
// 3. 참가신청 상태 사용자 정보에 반영

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

Future<PageCompetitionResponse> _getUserCompetition(String? token) async {
  late PageCompetitionResponse competitionResponse;
  late int? userId;

  String uri = "${baseUrl}user/userId";

  // userId가 속한 competition만 가져오기
  // await GetUserId(uri, token!).then(((value) async {
  //   String uri = "${baseUrl}competition/getCompetitions";
  //   userId = value;
  //   await GetCompetitions("$uri?userId=$userId", userId).then((value) {
  //     competitionResponse = value;
  //   });
  // }));

  // 모든 competition 가져오기
  await GetUserId(uri, token).then(((value) async {
    uri = "${baseUrl}competition/zget";
    userId = value;
    await GetCompetitionsAll(uri, userId).then((value) {
      print(value);
      competitionResponse = value;
    });
  }));

  print(
      "[debug] competitionResponse result: ${competitionResponse.competitions}, ${competitionResponse.userId}");
  return competitionResponse;
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    IsBrowsed isBrowsed = Provider.of<IsBrowsed>(context);
    PageCompetitionResponse competitionResponse =
        Provider.of<PageCompetitionResponse>(context);
    UserId userId = Provider.of<UserId>(context);

    TokenResponse tokenResponse = Provider.of<TokenResponse>(context);

    _getUserCompetition(tokenResponse.accessToken).then(((value) {
      print("[debug] provider: $isBrowsed");

      if (isBrowsed.isBrowsed == false) {
        setState(() {
          isBrowsed.isBrowsed = true;
          competitionResponse.competitions = value.competitions;
          competitionResponse.userId = value.userId;
          userId.userId = value.userId;
        });
      }
    }), onError: (err) {
      if (isBrowsed.isBrowsed == true) {
        setState(() {
          isBrowsed.isBrowsed = false;
        });
      }
    });

    if (isBrowsed.isBrowsed == false) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("홈",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFF6667AB),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: competitionResponse.competitions.length,
                    itemBuilder: ((context, index) {
                      return ContestTile(
                        index: index,
                        contest: competitionResponse.competitions[index],
                        detailType: DETAIL_TYPE.APPLY,
                      );
                    })))
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
            isBrowsed.isBrowsed = true;

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
                  break;

                case 2:
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: ((context) {
                    return MyInfoScreen();
                  })));
                  break;
              }
            });
          }),
        ),
      );
    }
  }
}
