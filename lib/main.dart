import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/view/screens/home_page.dart';
import 'package:todo_list/controller/task_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider<TasksController>(
      create: (context) => TasksController(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
