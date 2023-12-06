// class Task {
//   Task({required this.taskName, this.taskStatus = false});
//
//   String taskName;
//   bool taskStatus;
//
//   void toggleTask() {
//     taskStatus = !taskStatus;
//   }
// }
import 'dart:collection';
import 'dart:convert';
// import 'convert_task.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/controller/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

// @JsonSerializable()
class Task {
  final String taskName;
  bool taskStatus;

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskStatus': taskStatus,
    };
  }

  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'] as String,
        taskStatus = json['taskStatus'] as bool;

  Task({required this.taskName, this.taskStatus = false});

  void toggleTask() {
    taskStatus = !taskStatus;
  }
}
