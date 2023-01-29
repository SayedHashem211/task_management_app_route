import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_route/firebase_options.dart';
import 'package:todo_app_route/ui/home/home_page.dart';
import 'package:todo_app_route/ui/theme/my_theme.dart';

void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      routes: {
        HomePage.routeName : (_) => HomePage(),
      },
      initialRoute:HomePage.routeName ,
      theme: MyTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

