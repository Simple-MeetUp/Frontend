import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:dawu_start_from_homescreen/http/request.dart';
import 'package:dawu_start_from_homescreen/models/contest_user_list.dart';
import 'package:dawu_start_from_homescreen/providers/contest_user_list_api.dart';
import 'package:dawu_start_from_homescreen/screens/contest_approve_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ContestApproveScreen extends StatelessWidget {
  late CompetitionResponse contest;
  int competitionId = 0;

  List<String> keyList = ["내용", "관련 분야", "모집 인원", "활동 기간", "신청 기간"];
  Map<String, String> infoTable = {};

  ContestApproveScreen({required this.contest});

  // TO DO: implement below widgets
  @override
  Widget build(BuildContext context) {
    TokenResponse tokenResponse = Provider.of<TokenResponse>(context);
    MemberList memberList = Provider.of<MemberList>(context);
    AppliedList appliedList = Provider.of<AppliedList>(context);

    infoTable["내용"] = contest.contents ?? "";
    infoTable["관련 분야"] = contest.categories ?? "";
    infoTable["모집 인원"] =
        "최소 ${contest.personnelLowerBound}명 ~ 최대 ${contest.personnelUpperBound}명";
    infoTable["활동 기간"] =
        "${contest.activityDurationFrom} ~ ${contest.activityDurationTo}";
    infoTable["신청 기간"] =
        "${contest.enrollDurationFrom} ~ ${contest.enrollDurationTo}";
    competitionId = contest.competitionId!;


    return Scaffold(
      appBar: AppBar(
        title: const Text("공모전 정보",
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
                      onPressed: (() async{
                        // TO DO : 버튼 눌리면 신청자 목록 API 호출
                        // getParticipants getUsers
                        print('[debug] start API');
                        UserListRequest userListRequest = UserListRequest(
                          competitionId: competitionId,
                        );
                        String uri = "${baseUrl}competition/getUsers";
                        await GetUsers(uri, userListRequest).then((value) {
                          print('[debug] future successful');
                          // 팀원 list에 value 넘김
                          print('[debug] : ');
                          for(int i=0;i<value.userResponses!.length;i++){
                            ContestMemberListApi.appendUserList(value.userResponses![i]);
                          }
                          print('[debug] member');
                          print(value.userResponses);
                          print(memberList.memberList);
                        }, onError: (err) {
                          print(err.toString());
                            });
                        uri = "${baseUrl}competition/getParticipants";
                        await GetParticipants(uri, userListRequest).then((value) {
                          print('[debug] future successful');
                          // 참가 신청자 list에 value 넘김
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return ContestApproveConfirmScreen(
                              contest: contest,
                              competitionId: contest.competitionId ?? -1,
                            );
                          })));
                        }, onError: (err) {
                          print(err.toString());
                        });
                      }),
                      child: const Text("신청자 확인",
                          style: TextStyle(
                            fontSize: 15,
                          )))
                ],
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
