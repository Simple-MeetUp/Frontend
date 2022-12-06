import 'dart:async';

import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/request.dart';
import 'package:dawu_start_from_homescreen/screens/account/my_info_screen.dart';
import 'package:dawu_start_from_homescreen/screens/contest_list_screen.dart';
import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http/dto.dart';
import 'components/contest_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

Future<PageCompetitionResponse> _getUserId(String? token) async {
  String uri = "${baseUrl}user/userId";
  late int userId;
  late PageCompetitionResponse competitionResponse;

  await GetUserId(uri, token!).then(((value) async {
    String uri = "${baseUrl}competition/getCompetitions";
    userId = value;
    await GetCompetitions("$uri?userId=$userId", userId).then((value) {
      competitionResponse = value;
    });
  }));

  print(
      "[debug] competitionResponse result: ${competitionResponse.competitions}, ${competitionResponse.userId}");

  return competitionResponse;
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isChecked = false;
  bool isBrowsed = false;

  @override
  void didChangeDependencies() {
    isBrowsed = Provider.of<bool>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    bool isBrowsedProvider = Provider.of<bool>(context);
    PageCompetitionResponse competitionResponse =
        Provider.of<PageCompetitionResponse>(context);

    TokenResponse tokenResponse = Provider.of<TokenResponse>(context);

    _getUserId(tokenResponse.accessToken).then(((value) {
      print("[debug] provider: $isBrowsed");

      if (isBrowsed == false) {
        isBrowsedProvider = true;
        setState(() {
          isBrowsed = true;
          competitionResponse.competitions = value.competitions;
          competitionResponse.userId = value.userId;
        });

        print(
            "[debug] ${competitionResponse.competitions}, ${competitionResponse.userId}");
      }
    }), onError: (err) {
      if (isBrowsed == true) {
        setState(() {
          isBrowsed = false;
        });
      }
    });

    if (isBrowsed == false) {
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
                          contest: competitionResponse.competitions[index]);
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
            isBrowsedProvider = true;
            print("[debug] provider: $isBrowsedProvider");

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
