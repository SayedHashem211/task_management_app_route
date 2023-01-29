import 'package:flutter/material.dart';
import 'package:todo_app_route/ui/home/settings/settings_tab.dart';
import 'package:todo_app_route/ui/home/tasks/tasks_tab.dart';
import 'package:todo_app_route/ui/home/add_task_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndexTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon((Icons.add)),
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 4)),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndexTab,
          onTap: (index) {
            setState(() {
              selectedIndexTab = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            // must send label even its empty one!
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: ''),
          ],
        ),
      ),
      body: tabs[selectedIndexTab],
    );
  }

  var tabs = [TasksTab(), SettingsTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return  AddTaskScreen();
        });
  }
}
