import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFloatingButton extends StatefulWidget {
  final Function addTask;
  const MyFloatingButton({Key? key, required this.addTask}) : super(key: key);

  @override
  _MyFloatingButtonState createState() => _MyFloatingButtonState();
}

class _MyFloatingButtonState extends State<MyFloatingButton> {
  TextEditingController dateinput = TextEditingController();
  bool _show = true;
  int? _radioValue = 0;
  String _name = "";
  String _desc = "";
  String _priority = "urgent";
  void _handleRadioValueChange(int? value) {
    setState(() {
      switch (value) {
        case 0:
          _priority = "urgent";
          break;
        case 1:
          _priority = "important";
          break;
        case 2:
          _priority = "unimportant";
          break;
      }
      _radioValue = value;
    });
    print("first" + value.toString() + "radiovalue" + _radioValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Add new task',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              // autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
              onChanged: (value) {
                setState(() => _name = value);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: dateinput,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Due to',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                  print(formattedDate);

                  setState(() {
                    dateinput.text = formattedDate;
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description',
              ),
              onChanged: (value) {
                setState(() => _desc = value);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Urgent',
                  style: new TextStyle(fontSize: 12.0),
                ),
                Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Important',
                  style: new TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                Radio(
                  value: 2,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Unimportant',
                  style: new TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              child: ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (_name != "" && dateinput.text != "" && _desc != "") {
                    widget.addTask(_name, dateinput.text, _priority, _desc);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
