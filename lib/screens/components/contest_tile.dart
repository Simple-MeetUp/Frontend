import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:dawu_start_from_homescreen/screens/contest_approve_screen.dart';
import 'package:dawu_start_from_homescreen/screens/contest_detail_screen.dart';
import 'package:flutter/material.dart';

class ContestTile extends StatelessWidget {
  final int index;
  final CompetitionResponse contest;
  final DETAIL_TYPE detailType;

  const ContestTile(
      {required this.index, required this.contest, required this.detailType});

  @override
  Widget build(BuildContext context) {
    print(
        "[debug] ContestTile: $index, ${contest.title}, ${contest.categories}"); // 절대 지우지 말 것

    return ListTile(
      title: Text(contest.title ?? ""),
      subtitle: Text(contest.categories ?? ""),
      onTap: () {
        if (detailType == DETAIL_TYPE.APPLY) {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return ContestDetailScreen(index: index, contest: contest);
          })));
        } else if (detailType == DETAIL_TYPE.APPROVE) {
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
            return ContestApproveScreen(contest: contest);
          })));
        }
      },
    );
  }
}
