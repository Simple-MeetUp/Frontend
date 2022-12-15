import 'package:dawu_start_from_homescreen/constants.dart';
import 'package:dawu_start_from_homescreen/http/dto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final PageCompetitionResponse contestList =
        Provider.of<PageCompetitionResponse>(context);
    List<int> true_index = [];

    return ListView.builder(
        shrinkWrap: true,
        itemCount: contestList.competitions.length,
        itemBuilder: ((context, index) {

          // for(int i=0;i<index;i++){
          //   if(isOwner(contestList.competitions[i]) == true){
          //    //   true_index [append];
          //    //   return ContestTile();
          //   }
          // }


          return ContestTile(
            index: index,
            contest: contestList.competitions[index],
            detailType: DETAIL_TYPE.APPROVE,
          );
        }));
  }
}
