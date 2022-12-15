import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:flutter/material.dart';

// 신청자 확인 기능 TO DO:
// 0. 현재 화면에서 didChangeDependencies() life cycle 메서드에서
//    API 호출하여 현재 팀원 목록, 신청자 목록을 가져온다.
//      -> 왜 하필 didChangeDependencies()인가?
//      -> 위젯 생성하는 build 이전에 context를 사용할 수 있는 유일한 생명주기 함수이므로
// 1. 신청자 확인 버튼 누르면 신청자 목록 업데이트 API 호출
// 2. 현재 팀원 목록 GridView 구현
// 3. 신청자 목록 GridView 구현

class ContestApproveConfirmScreen extends StatefulWidget {
  final CompetitionResponse contest;
  final int competitionId;

  const ContestApproveConfirmScreen(
      {required this.contest, required this.competitionId});

  @override
  _ContestApproveConfirmScreenState createState() =>
      _ContestApproveConfirmScreenState(
          contest: contest, competitionId: competitionId);
}

class _ContestApproveConfirmScreenState
    extends State<ContestApproveConfirmScreen> {
  final CompetitionResponse contest;
  final int competitionId;

  _ContestApproveConfirmScreenState(
      {required this.contest, required this.competitionId});

  @override
  void didChangeDependencies() {
    // API 호출 부분

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("신청자 확인",
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
                  Text(contest.title ?? "",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6667AB)),
                      onPressed: (() {
                        // TO DO: 승인완료 버튼 누르면 신청자 목록 업데이트 API 호출
                      }),
                      child: const Text("승인완료",
                          style: TextStyle(
                            fontSize: 15,
                          )))
                ],
              ),
              const Padding(padding: EdgeInsets.all(10)),
              Container(
                alignment: Alignment.topLeft,
                child: const Text("지원 분야",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const SizedBox(
                height: 160,
                // TO DO : 현재 팀원 목록 GridView 구현
                // child: GridView.builder(
                //     gridDelegate: gridDelegate, itemBuilder: itemBuilder),
              ),
              const Padding(padding: EdgeInsets.all(40)),
              Container(
                alignment: Alignment.topLeft,
                child: const Text("신청자 목록",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const SizedBox(
                height: 160,
                // TO DO : 신청자 목록 GridView 구현
                // child: GridView.builder(
                //     gridDelegate: gridDelegate, itemBuilder: itemBuilder),
              ),
            ],
          )
        ],
      ),
    );
  }
}
