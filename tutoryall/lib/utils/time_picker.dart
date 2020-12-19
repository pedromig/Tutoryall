import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldTimePicker extends StatefulWidget {
  final ValueChanged<DateTime> onTimeChanged;
  final DateTime initialTime;
  final FocusNode focusNode;
  final Icon prefixIcon;
  final Icon suffixIcon;

  TextFieldTimePicker({
    Key key,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    @required this.initialTime,
    @required this.onTimeChanged,
  });

  @override
  _TextFieldTimePicker createState() => _TextFieldTimePicker();
}

class _TextFieldTimePicker extends State<TextFieldTimePicker> {
  TextEditingController _controllerTime;
  DateTime _selectedTime;
  DateFormat _timeFormat;

  @override
  void initState() {
    super.initState();

    _timeFormat = DateFormat.Hm();
    _selectedTime = widget.initialTime;

    _controllerTime = TextEditingController();
    _controllerTime.text = _timeFormat.format(_selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: _controllerTime,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      onTap: () => _selectTime(context),
      readOnly: true,
    );
  }

  @override
  void dispose() {
    _controllerTime.dispose();
    super.dispose();
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTime),
    );

    DateTime _now = DateTime.now();
    DateTime time = DateTime(
        _now.year, _now.month, _now.day, pickedTime.hour, pickedTime.minute);

    if (pickedTime != null) {
      _selectedTime = time;
      _controllerTime.text = _timeFormat.format(_selectedTime);
      widget.onTimeChanged(time);
    }

    if (widget.focusNode != null) {
      widget.focusNode.nextFocus();
    }
  }
}
