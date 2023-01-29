import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_route/database/my_database.dart';
import 'package:todo_app_route/utils/dialog_utils.dart';

import '../../../database/task_model.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2, // نسبة استحواذها علي الاسكرين
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildContext) {
                deleteTask();
              },
              backgroundColor: Colors.red,
              label: 'Delete',
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Colors.white),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                     Text(widget.task.description)
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 32,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() {
    DialogUtils.showMessage(context, 'Are you sure that you want to delete this task ?' ,
    positiveActionTitle: 'Yes' ,
      positiveAction: ()async{
      DialogUtils.showProgressDialog(context, 'Loading...');
      await MyDatabase.deleteTask(widget.task);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Task Deleted Successfully',
        positiveActionTitle: 'Ok',
        negativeActionTitle: 'Undo',
        negativeAction: (){
        // undo deleting task
        }
      );
    },
      negativeActionTitle: 'Cancel',
    );

  }
}
