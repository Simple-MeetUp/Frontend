import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() {
    return _DatePickerPageState();
  }
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime? _selectedDate;
  late String _selectedDateString;

  @override
  void initState() {
    super.initState();
    _selectedDateString = "탭하여 등록하기";
  }

  Future _pickDateDialog(BuildContext context) async {
    final initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );

    if (pickedDate == null) return;

    setState(() {
      _selectedDate = pickedDate;
      _selectedDateString = DateFormat('yyyy-MM-dd').format(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: Row(
          children: [
            TextButton(
              onPressed: (() => _pickDateDialog(context)),
              child: Text(
                _selectedDateString,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ));
  }
}
