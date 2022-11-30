import 'package:flutter/material.dart';

import '../../constants.dart';

class ShowingSpecTile extends StatefulWidget {
  final String specName;

  const ShowingSpecTile({required this.specName});

  @override
  State<StatefulWidget> createState() {
    return _ShowingSpecTileState(specName: specName);
  }
}

class _ShowingSpecTileState extends State<ShowingSpecTile> {
  final String specName;
  bool? isChecked = false;

  _ShowingSpecTileState({required this.specName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            specName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Checkbox(
            value: isChecked,
            onChanged: ((value) {
              setState(() {
                isChecked = value;
              });
            }),
            activeColor: defaultColor,
          )
        ],
      ),
    );
  }
}
