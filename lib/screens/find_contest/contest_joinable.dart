import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Contest.dart';
import '../components/contest_tile.dart';

// 참여 가능 TabView
class JoinableContestScreen extends StatefulWidget {
  @override
  _JoinableContestScreenState createState() {
    return _JoinableContestScreenState();
  }
}

class _JoinableContestScreenState extends State<JoinableContestScreen> {
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
