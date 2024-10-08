import 'package:flutter/material.dart';

void main(){
  runApp(Tasks());
}

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskList> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();
  
  void addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'name': taskController.text,
          'isCompleted': false,
        });
      });
      taskController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter Task",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: Checkbox(
                    value: tasks[index]['isCompleted'],
                    onChanged: (bool? value){
                      setState(() {
                        tasks[index]['isCompleted'] = value!;
                      });
                    },
                  ),
                  title: Text(
                    tasks[index]['name'],
                    style: TextStyle(
                      decoration: tasks[index]['isCompleted']
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      setState(() {
                        tasks.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}