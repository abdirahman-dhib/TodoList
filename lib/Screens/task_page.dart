import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist_app/model/task_model.dart';
import 'package:todolist_app/util/dialog_box.dart';
import 'package:todolist_app/util/hold_task..dart';
import 'package:http/http.dart' as http;
//import 'package:cloud_firestore/cloud_firestore.dart';


class TastkPage extends StatefulWidget {
  const TastkPage({super.key});

  @override
  State<TastkPage> createState() => _TastkPageState();
}

class _TastkPageState extends State<TastkPage> {

  //Database

  // CollectionReference task_database =FirebaseFirestore.instance.collection('tasks');
  
  // text Controller

  //List of todo tasks
  List toDolist = [
    ['make what you want', false],
    ['Do exedxrcise', true],
    ['make what you want', true],
  ];
  //Chechbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDolist[index][1] = !toDolist[index][1];
    });
  }

//Save new Task
void saveNewTask(){
  setState(() {
    toDolist.add([_controller.text,false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
}



// Create New task
 void createNewTask(){
 showDialog(context: context, builder: (context) {
   return DialogBox(
    controller: _controller,
    onSave: saveNewTask,
    OnCancel: ()=> Navigator.of(context).pop(),
   );
 },);
 }

 //Delete task
 void deleteTask(int index){
  setState(() {
    toDolist.removeAt(index);
  });
 }
final _controller = TextEditingController();
 // fron Json
  List<Task> TasksJ=[];
  Future<List<Task>> getTasks()async{
    try{
      
    var response = await http.get(Uri.parse('http://192.168.100.12:5000/api/tasks'));
      print(response.body);
      if(response.statusCode==200){
       List data = jsonDecode(response.body);
       print(data);
       for( var element in data){
        TasksJ.add(Task.fromJson(element));
       }
      }
    }catch(e){
       print('Error $e');
    }
    return TasksJ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed:createNewTask ,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Task>>(
        future: getTasks(),
        builder: (contex,snapshot){
          if(snapshot.hasData){
            return  ListView.builder(
                itemCount: toDolist.length,
                itemBuilder: (context, index) {
                  return HoldTask(
                    taskName: toDolist[index][0],
                    taskCompleted: toDolist[index][1],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFuntion: (context)=> deleteTask(index),
                  );
                });

          }else if(snapshot.hasError){ 
            return Text('Error Occured');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
