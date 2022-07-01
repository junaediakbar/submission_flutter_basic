import 'package:dicoding_flutter_fundamental/models/task.dart';
import 'package:flutter/material.dart';

class DetailTask extends StatelessWidget {
  Task task;
  DetailTask(this.task, {Key? key}) : super(key: key);

  Color getColor(task) {
    return task.priority == 'urgent'
        ? Colors.teal
        : task.priority == 'important'
            ? Colors.orange
            : Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 32, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    highlightColor: Colors.grey,
                    splashRadius: 28,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                    child: Text(
                      task.name,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'due to ${task.date}',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      task.priority,
                      style: TextStyle(color: getColor(task)),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: getColor(task), spreadRadius: 0.5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Text(
                  task.description,
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.black45),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.blue, spreadRadius: 0.5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
