import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState() {
    return _TimePickerPageState();
  }
}

class _TimePickerPageState extends State<TimePickerPage> {
  String _pickedTimeString = "";

  Future _pickTimeDialog(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime == null) return;

    setState(() {
      _pickedTimeString = "${pickedTime.hour}:${pickedTime.minute}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.13,
      height: 30,
      child: TextButton(
        onPressed: (() => _pickTimeDialog(context)),
        child: Text(
          _pickedTimeString,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
