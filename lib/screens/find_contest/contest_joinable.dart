import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final PageCompetitionResponse contestList =
        Provider.of<PageCompetitionResponse>(context);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: contestList.competitions.length,
        itemBuilder: ((context, index) {
          return ContestTile(
            index: index,
            contest: contestList.competitions[index],
            detailType: DETAIL_TYPE.APPLY,
          );
        }));
  }
}
