import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/database_services.dart';

class TasksData extends ChangeNotifier{
  List<Task> tasks=[];

  void addTasks(String taskTitle) async{
    Task task=await DatabaseServices.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task){
    task.toggle();
    DatabaseServices.updateTask(task.id);
    notifyListeners();
  }

  void deleteTask(Task task){
    tasks.remove(task);
    DatabaseServices.deleteTask(task.id);
    notifyListeners();
  }
}