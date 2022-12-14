import 'package:dawu_start_from_homescreen/models/Contest.dart';
import 'package:dawu_start_from_homescreen/providers/contest_list_api.dart';
import 'package:dawu_start_from_homescreen/screens/contest_apply_screen.dart';
import 'package:flutter/material.dart';

class ContestDetailScreen extends StatelessWidget {
  final int index;
  late Contest contest;

  List<String> keyList = ["내용", "관련 분야", "모집 인원", "활동 기간", "신청 기간"];
  Map<String, String> infoTable = {};

  ContestDetailScreen({required this.index});

  // TO DO: implement below widgets
  @override
  Widget build(BuildContext context) {
    contest = ContestListApi.getContest(index);

    infoTable["내용"] = contest.contestInfo.description.toString();
    infoTable["관련 분야"] = contest.contestInfo.field.toString();
    infoTable["모집 인원"] =
        "최소 ${contest.contestInfo.minPeople}명 ~ 최대 ${contest.contestInfo.maxPeople}명";
    infoTable["활동 기간"] =
        "${contest.contestInfo.activityStartPeriod} ~ ${contest.contestInfo.activityDuePeriod}";
    infoTable["신청 기간"] =
        "${contest.contestInfo.registerStartPeriod} ~ ${contest.contestInfo.registerDuePeriod}";

    return Scaffold(
      appBar: AppBar(
        title: const Text("공모전 찾기",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF6667AB),
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
                          backgroundColor: const Color(0xFF6667AB)),
                      onPressed: (() {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: ((context) {
                          return ContestApplyScreen();
                        })));
                      }),
                      child: const Text("참가신청",
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
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 8,
                    childAspectRatio:
                        MediaQuery.of(context).size.height * 0.0028,
                  ),
                  itemCount: keyList.length * 2,
                  itemBuilder: ((context, index) {
                    // 짝수 인덱스면 키에서 꺼내고, 홀수 인덱스면 값에서 꺼낸다.
                    if (index % 2 == 0) {
                      return Text(keyList[index ~/ 2],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold));
                    } else {
                      return Text(infoTable[keyList[index ~/ 2]] ?? "",
                          style: const TextStyle(fontSize: 14));
                    }
                  }))
            ],
          )
        ],
      ),
    );
  }
}
