import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:dawu_start_from_homescreen/screens/contest_register_screen.dart';
import 'package:dawu_start_from_homescreen/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'find_contest/contest_completed.dart';
import 'find_contest/contest_joinable.dart';
import 'find_contest/contest_ongoing.dart';

class ContestListScreen extends StatefulWidget {
  @override
  _ContestListScreenState createState() {
    return _ContestListScreenState();
  }
}

class _ContestListScreenState extends State<ContestListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("공모전 찾기",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6667AB),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.fromLTRB(-16, -4, -16, 0),
          indicator: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.white24),
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text("참여 가능", style: TextStyle(fontSize: 20)),
            ),
            Tab(
              child: Text("진행중", style: TextStyle(fontSize: 20)),
            ),
            Tab(
              child: Text("완료", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        OngoingContestScreen(),
        JoinableContestScreen(),
        CompletedContestScreen()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6667AB),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return ContestRegisterScreen();
          })));
        },
      ),
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
