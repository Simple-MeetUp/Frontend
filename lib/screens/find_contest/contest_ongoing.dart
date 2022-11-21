import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Contest.dart';
import '../components/contest_tile.dart';

// 진행중 TabView
class OngoingContestScreen extends StatefulWidget {
  @override
  _OngoingContestScreenState createState() {
    return _OngoingContestScreenState();
  }
}

class _OngoingContestScreenState extends State<OngoingContestScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Contest> contestList = Provider.of<List<Contest>>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: contestList.length,
        itemBuilder: ((context, index) {
          return ContestTile(
            index: index,
            contest: contestList[index],
          );
        }));
  }
}
