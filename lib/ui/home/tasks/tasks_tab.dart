import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_app_route/database/my_database.dart';

import '../../../database/task_model.dart';
import '../widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  List<Task> allTasks = [];

  // @override
  // void initState() {
  //   super.initState();
  //   loadTasks();
  // }

  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              if (date == null){
                return;
              }
              setState(() {
                selectedDate = date;
              });
            },
            leftMargin: 20,
            monthColor: Colors.black,
            dayColor: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Colors.white,
            dotsColor: Theme.of(context).primaryColor,
            selectableDayPredicate: (date) =>
                true, // date.day != 23  => To disable choosing custom day
            locale: 'en_ISO',
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDatabase.getTasksRealTimeUpdates(selectedDate),
            builder: (buildContext, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   // future func hasn't  completed yet
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text('Loading Task Error , Try Again'),
                      // show try again button
                    ],
                  ),
                );
              }
              var tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
              return ListView.builder(
                itemBuilder: (_, index) {
                  return TaskItem(tasks![index]);
                },
                itemCount: tasks?.length ?? 0,
              );
            },
          )
              // FutureBuilder<List<Task>>(
              // future:MyDatabase.getTasks(),
              //   builder: (buildContext , snapshot){
              //
              //   if (snapshot.hasError){
              //     return Center(
              //       child: Column(
              //         children: [
              //           Text('Loading Task Error , Try Again'),
              //           // show try again button
              //         ],
              //       ),
              //     );
              //   }
              //   var tasks = snapshot.data;
              //   return ListView.builder(itemBuilder: (_, index){
              //     return  TaskItem(tasks![index]);
              //   },
              //     itemCount: tasks?.length ?? 0,
              //   );
              //   },
              // )

              )
        ],
      ),
    );
  }

  void loadTasks() async {
    //call database to get tasks
    //then reload widget to view tasks
    allTasks = await MyDatabase.getTasks(selectedDate);
    setState(() {

    });
  }
}

// used in method 1 =>
/*
  ListView.builder(itemBuilder: (_, index){
              return  TaskItem(allTasks[index]);
            },
            itemCount: allTasks.length,
            ),
*/

/*
// if (snapshot.connectionState == ConnectionState.waiting){
                  //   // future func hasn't  completed yet
                  //   return Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  //}
*/
