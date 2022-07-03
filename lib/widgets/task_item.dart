import 'package:flutter/material.dart';
import '../models/task.dart';
import '../pages/detail_task.dart';

// ignore: must_be_immutable
class TaskItem extends StatelessWidget {
  final Task task;
  Function removeTask;
  TaskItem({Key? key, required this.task, required this.removeTask})
      : super(key: key);

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        removeTask(task.id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: const Text(
          "Do you sure want to delete this task forever from the list?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double titleSize = 16;
    double subtitleSize = 14;
    if (screenSize.width > 350) {
      subtitleSize = 14;
      titleSize = 16;
    } else {
      titleSize = 12;
      subtitleSize = 8;
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            task.name,
            style: TextStyle(
              fontSize: titleSize,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              size: 20.0,
              color: Colors.red,
            ),
            onPressed: () {
              showAlertDialog(context);
            },
          ),
          subtitle: Text(
            task.date,
            style: TextStyle(
              fontSize: subtitleSize,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailTask(task);
            }));
          },
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      color: task.priority == 'urgent'
          ? Colors.lime.shade100
          : task.priority == 'important'
              ? Colors.orange.shade100
              : Colors.amber.shade100,
    );
  }
}
