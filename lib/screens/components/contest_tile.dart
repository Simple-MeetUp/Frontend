import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:dawu_start_from_homescreen/screens/contest_detail_screen.dart';
import 'package:flutter/material.dart';

class ContestTile extends StatelessWidget {
  final int index;
  final CompetitionResponse contest;

  const ContestTile({required this.index, required this.contest});

  @override
  Widget build(BuildContext context) {
    print(
        "[debug] ContestTile: $index, ${contest.title}, ${contest.categories}"); // 절대 지우지 말 것

    return ListTile(
      title: Text(contest.title ?? ""),
      subtitle: Text(contest.categories ?? ""),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return ContestDetailScreen(index: index, contest: contest);
        })));
      },
    );
  }
}
