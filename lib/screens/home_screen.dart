import 'package:dawu_start_from_homescreen/models/current_index.dart';
import 'package:dawu_start_from_homescreen/screens/contest_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final CurrentIndex currentIndex = Provider.of<CurrentIndex>(context);
    final List<Contest> contestList = Provider.of<List<Contest>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("홈",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6667AB),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "전체목록",
                style: TextStyle(fontSize: 14),
              ),
              Checkbox(
                  value: isChecked,
                  onChanged: ((value) {
                    setState(() {
                      isChecked = value;
                    });
                  }))
            ],
          ),
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
                break;
            }
          });
        }),
      ),
    );
  }
}
