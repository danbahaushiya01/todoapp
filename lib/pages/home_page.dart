import 'package:flutter/material.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List of Tasks
  List toDoList = [
    ["Make tutorial", true],
    ["Do Excercise", false],
  ];

  // checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      //changing the state of a task
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // creating new task
  void createNewTask() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        //appBar
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Center(child: Text('TO DO')),
        ),
        //Floating Button actions to add new field
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: createNewTask,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: toDoList[index][0],
              taskCompleted: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
            );
          },
        )

        //body
        // body: ListView(
        //   children: [
        //     ToDoTile(
        //       taskName: "Make Tutorial",
        //       taskCompleted:true,
        //       onChanged: (p0) {

        //       },
        //     ),
        //     ToDoTile(
        //       taskName: "Do Excercise",
        //       taskCompleted:false,
        //       onChanged: (p0) {

        //       },
        //     ),

        //   ],
        //),
        );
  }
}
