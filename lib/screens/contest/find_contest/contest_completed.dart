import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/contest_tile.dart';

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
    final PageCompetitionResponse contestList =
        Provider.of<PageCompetitionResponse>(context);

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
