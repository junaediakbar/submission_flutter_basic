import '../models/task.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/task_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  List<Task> listTasks = [
    Task('1', 'Belajar Flutter Basic', '24-12-2022', 'urgent',
        '- Dart \n- Installation \n- Widget '),
    Task('2', 'Belajar Membuat Widgets', '30-12-2022', 'important',
        '- Statefull dan Stateless \n- Navigation '),
    Task('3', 'Nonton Series', '28-1-2023', 'unimportant',
        '- Startup \n- Bussiness Proposal'),
  ];

  void _addNewTask(String _name, String _date, String _priority, String _desc) {
    setState(() {
      int id = listTasks.length + 1;
      listTasks.add(Task(id.toString(), _name, _date, _priority, _desc));
    });
  }

  void _removeThisTask(String id) {
    setState(() {
      listTasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double titleSize = 28;
    double subtitleSize = 14;
    if (screenSize.width > 350) {
      subtitleSize = 14;
      titleSize = 28;
    } else if (screenSize.width > 275 && screenSize.width < 350) {
      titleSize = 16;
      subtitleSize = 12;
    } else {
      titleSize = 12;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              margin: const EdgeInsets.only(bottom: 12),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 36),
                        Text(
                          'Hi, New User',
                          style: TextStyle(
                            fontSize: titleSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Let\'s do your tasks!',
                          style: TextStyle(
                            fontSize: subtitleSize,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://picsum.photos/seed/picsum/500/500'),
                    )
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [BoxShadow(blurRadius: 3.0)],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(18.0)),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: listTasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItem(
                  task: listTasks[index],
                  removeTask: _removeThisTask,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return MyFloatingButton(addTask: _addNewTask);
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
