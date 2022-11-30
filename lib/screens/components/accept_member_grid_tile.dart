import 'package:flutter/material.dart';

import '../../models/user_attribute.dart';
import '../../providers/user_attribute_api.dart';

class AcceptMemberGridTile extends StatefulWidget {
  @override
  _AcceptMemberGridTileState createState() {
    return _AcceptMemberGridTileState();
  }
}

class _AcceptMemberGridTileState extends State<AcceptMemberGridTile> {
  late UserAttribute userAttribute;

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    userAttribute = UserAttributeApi.getUserAttribute()!;

    if (userAttribute == null) {
      return GridTile(
          child: Row(children: const [Text(""), Text(""), Text(""), Text("")]));
    }

    userAttribute.show();

    return GridTile(
        child: Container(
      child: Row(children: [
        Checkbox(
            value: isChecked,
            onChanged: ((value) {
              setState(() {
                isChecked = value;
              });
            })),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Text(userAttribute.name),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Text(userAttribute.field),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        Text(userAttribute.joinedCount.toString()),
        const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
        IconButton(
          icon: const Icon(
            Icons.list_alt,
            color: Colors.black26,
            size: 32,
          ),
          onPressed: (() {
            showDialog(
                context: context,
                builder: ((context) {
                  List<Text> fieldTextList = [];
                  List<Widget> widgetList = [
                    const Padding(padding: EdgeInsets.all(8))
                  ];

                  List<String> fieldList = userAttribute.joinedContestList;

                  for (String field in fieldList) {
                    fieldTextList.add(Text(
                      field,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ));
                  }

                  for (int i = 0; i < fieldList.length; i++) {
                    widgetList.add(fieldTextList[i]);
                    widgetList.add(const Padding(padding: EdgeInsets.all(4)));
                  }

                  return SimpleDialog(
                    title: const Text("참여한 공모전 목록"),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widgetList,
                      )
                    ],
                  );
                }));
          }),
        )
      ]),
    ));
  }
}
