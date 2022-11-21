import 'package:dawu_start_from_homescreen/screens/contest_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../models/Contest.dart';

class ContestTile extends StatelessWidget {
  final int index;
  final Contest contest;

  const ContestTile({required this.index, required this.contest});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contest.title),
      subtitle: Text(contest.subtitle),
      leading: Image.network(
        contest.thumbnail,
        width: MediaQuery.of(context).size.width * 0.13,
        fit: BoxFit.fitWidth,
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
          return ContestDetailScreen(index: index);
        })));
      },
    );
  }
}
