import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tasks_data.dart';
import 'package:todo/services/database_services.dart';

import '../models/task.dart';
import '../task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

  getTasks() async{
    tasks=await DatabaseServices.getTasks();
    Provider.of<TasksData>(context,listen: false).tasks=tasks!;
    setState(() {

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return tasks == null?
        const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
        : Scaffold(
          appBar: AppBar(
            title: Text(
              'Todo Tasks (${Provider.of<TasksData>(context).tasks.length})',
            ),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Consumer<TasksData>(
              builder: (context,tasksData, child){
                return ListView.builder(
                    itemCount: tasksData.tasks.length,
                    itemBuilder: (context, index){
                      Task task = tasksData.tasks[index];
                      return TaskTile(
                        task: task,
                        tasksData: tasksData,
                      );
                    }
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
            ),
            onPressed: (){
              showModalBottomSheet(
                  context: context,
                  builder: (context){
                    return const AddTaskScreen();
                  }
              );
            },
          ),
        );
  }
}
