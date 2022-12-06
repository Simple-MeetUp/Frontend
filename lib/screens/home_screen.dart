import 'dart:async';

import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/request.dart';
import 'package:dawu_start_from_homescreen/screens/account/my_info_screen.dart';
import 'package:dawu_start_from_homescreen/screens/contest_list_screen.dart';
import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http/dto.dart';
import '../models/Contest.dart';
import 'components/contest_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isChecked = false;

  bool isBrowsed = false; // 공모전 목록 불러오기 여부
  int interval = 600; // competition 오류 발생 시, 요청을 다시 보내는 주기 (초 단위)

  late PageCompetitionResponse? competitionResponse;

  Future<PageCompetitionResponse?> getCompetitions(
      BuildContext context, String? token) async {
    const String uri = "${baseUrl}api​/competition​/getCompetitions";
    late int? userId;
    late PageCompetitionResponse? competitionResponse;

    await GetUserId(uri, token!).then(((value) async {
      userId = value;
      await GetCompetitions(uri, userId!).then((value) {
        setState(() {
          competitionResponse = value;
        });
        return competitionResponse;
      });
    }));
    return null;
  }

  void showNetworkErrorDialog(BuildContext context, String? token) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text("오류"),
            content: const Text("서버와의 통신이 원활하지 않습니다.\n잠시 후 시도하세요."),
            actions: [
              TextButton(
                  onPressed: (() async {
                    await getCompetitions(context, token).then((value) {
                      setState(() {
                        competitionResponse = value;
                      });
                    });
                  }),
                  child: const Text("다시 시도"))
            ],
          );
        }));
  }

  @override
  void didChangeDependencies() {
    TokenResponse tokenResponse = Provider.of<TokenResponse>(context); // debug
    print("[debug] accessToken: ${tokenResponse.accessToken}");
    print("[debug] refreshToken: ${tokenResponse.refreshToken}");

    getCompetitions(context, tokenResponse.accessToken).then((value) {
      print(
          "[debug] userId: ${value?.userId}, competitions: ${value?.competitions}");
      isBrowsed = true;
    }, onError: (err) {
      print(
          "An error occured: ${err.toString()}.\nRetry in 5 seconds later...");
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    final List<Contest> contestList = Provider.of<List<Contest>>(context);

    TokenResponse tokenResponse = Provider.of<TokenResponse>(context); // debug

    if (isBrowsed == false) {
      showNetworkErrorDialog(context, tokenResponse.accessToken);
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("홈",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6667AB),
      ),
      body: Column(
        children: [
          // https://stackoverflow.com/questions/53974288/flutter-listview-bottom-overflow
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: contestList.length,
                  itemBuilder: ((context, index) {
                    return ContestTile(
                        index: index, contest: contestList[index]);
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
