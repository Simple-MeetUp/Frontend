import 'package:dawu_start_from_homescreen/screens/components/accept_member_grid_tile.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/Contest.dart';
import '../providers/contest_list_api.dart';

class ContestAcceptMemberScreen extends StatefulWidget {
  @override
  _ContestAcceptMemberScreenState createState() {
    return _ContestAcceptMemberScreenState(index: 0);
  }
}

class _ContestAcceptMemberScreenState extends State<ContestAcceptMemberScreen> {
  final int index;

  _ContestAcceptMemberScreenState({required this.index});

  @override
  Widget build(BuildContext context) {
    Contest contest = ContestListApi.getContest(index);

    return Scaffold(
      appBar: AppBar(
        title: const Text("공모전 찾기",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: defaultColor,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(contest.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: defaultColor),
                      onPressed: (() {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: ((context) {
                          return ContestAcceptMemberScreen();
                        })));
                      }),
                      child: const Text("신청자 확인",
                          style: TextStyle(
                            fontSize: 15,
                          )))
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Image.network(
                contest.thumbnail,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.fitHeight,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "현재 팀원 목록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                    itemCount: 2,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 50,
                      childAspectRatio: 7 / 1,
                    ),
                    itemBuilder: ((context, index) => AcceptMemberGridTile())),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "신청자 목록",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 200,
                child: GridView.builder(
                    itemCount: 2,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 7 / 1,
                    ),
                    itemBuilder: ((context, index) => AcceptMemberGridTile())),
              ),
            ],
          )
        ],
      ),
    );
  }
}
