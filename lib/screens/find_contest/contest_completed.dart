import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Contest.dart';
import '../components/contest_tile.dart';

//  TabView
class CompletedContestScreen extends StatefulWidget {
  @override
  _CompletedContestScreenState createState() {
    return _CompletedContestScreenState();
  }
}

class _CompletedContestScreenState extends State<CompletedContestScreen> {
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
