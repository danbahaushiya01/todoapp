import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference to hive
  final _myBox = Hive.box('mybox');
 
  // text controller
  final _controller = TextEditingController();
  //List of Tasks
 ToDoDataBase db = ToDoDataBase();

@override
  void initState() {
    //if this is the first time ever opening the app, then create default data
    if(_myBox.get("TODOLIST")== null){
        db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }





  // checkBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      //changing the state of a task
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
  }

// creating method to Save new Tasks
void saveNewTask(){
  setState(() {
db.toDoList.add([_controller.text,false]);
  _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateDataBase();
}

  // creating new task
  void createNewTask() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller:_controller ,
            onSave:saveNewTask ,
            onCancel: () => Navigator.of(context).pop(),
          );
        },
      );
    });
  }

  // deleting a task
  void deleteTask(int index){
     setState(() {
        db.toDoList.removeAt(index);
     });
       db.updateDataBase();
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
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
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
