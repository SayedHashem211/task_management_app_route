import 'package:flutter/material.dart';
import 'package:todo_app_route/database/my_database.dart';
import 'package:todo_app_route/utils/date_format.dart';

import '../../database/task_model.dart';
import '../../utils/dialog_utils.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a valid title';
                }
                return null; // no error
              },
            ),
            TextFormField(
              controller: descriptionController,
              minLines: 4,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'description',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a valid description';
                }
                if (value.length <= 3) {
                  return 'description should be more than 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Select Date',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  showTaskDatePicker();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(MyDateUtils.formatTaskDate(selectedDate)),
                )),
            const SizedBox(
              height: 3,
            ),
            ElevatedButton(
                onPressed: () {
                  insertTask();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();

  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (userSelectedDate == null) {
      return;
    }
    setState(() {
      selectedDate = userSelectedDate;
    });
  }

  void insertTask() async {
    // 1. validation
    if (formKey.currentState?.validate() == false) {
      return;
    }
    // 2. insert task
    Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate);
    // loading ...!
    DialogUtils.showProgressDialog(context, 'Loading...', isDismissible: false);
    try {
      await MyDatabase.insertTask(task); // don't take time (non blocking func)
      DialogUtils.hideDialog(context);
      // show that task inserted successfully..!
      DialogUtils.showMessage(context, 'Task inserted successfully..!',
          positiveActionTitle: 'Ok',
          positiveAction: () {
            Navigator.pop(context);
          },
          negativeActionTitle: 'Cancel',
          negativeAction: () {
            Navigator.pop(context);
          },
          isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Inserting task Error',
          positiveActionTitle: 'Try Again',
          positiveAction: () {
            insertTask();
          },
          negativeActionTitle: 'Cancel',
          negativeAction: () {
            Navigator.pop(context);
          },
          isDismissible: true);
    }
  }
}
