import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/screen/tasks.dart';
import 'package:todo_app_with_firebase/widget/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("To-Do List"),
        ),
        extendBody: true,
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddTaskAlertDialog();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: const Center(
          child: Tasks(),
        ));
  }
}
