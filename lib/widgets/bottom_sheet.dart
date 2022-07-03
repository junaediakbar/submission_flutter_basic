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
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double radioScale = 1;
    double textInputSize;
    double titleSize = 16;
    double radioTextSize = 12;
    if (screenSize.width > 350) {
      textInputSize = 16;
      radioTextSize = 12;
      radioScale = 1;
    } else if (screenSize.width > 275 && screenSize.width < 350) {
      textInputSize = 12;
      titleSize = 12;
      radioScale = 0.6;
      radioTextSize = 8;
    } else {
      textInputSize = 12;
      radioScale = 0.5;
      radioTextSize = 8;
    }
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Add new task',
              style: TextStyle(
                fontSize: titleSize,
                color: Colors.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              style: TextStyle(fontSize: textInputSize),
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
              style: TextStyle(fontSize: textInputSize),
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
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(pickedDate);

                  setState(() {
                    dateinput.text = formattedDate;
                  });
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              style: TextStyle(fontSize: textInputSize),
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
              children: [
                Row(
                  children: <Widget>[
                    Transform.scale(
                      scale: radioScale,
                      child: Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ),
                    Text(
                      'Urgent',
                      style: TextStyle(
                        fontSize: radioTextSize,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Transform.scale(
                      scale: radioScale,
                      child: Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ),
                    Text(
                      'Important',
                      style: TextStyle(
                        fontSize: radioTextSize,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Transform.scale(
                      scale: radioScale,
                      child: Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                    ),
                    Text(
                      'Unimportant',
                      style: TextStyle(
                        fontSize: radioTextSize,
                      ),
                    ),
                  ],
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
