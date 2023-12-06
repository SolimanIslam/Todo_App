// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list/controller/task_controller.dart';
//
// class AddTaskPage extends StatelessWidget {
//   String? newTaskTitle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//       padding: const EdgeInsets.all(30),
//       child: Column(
//         children: [
//           const Text('Add Task',
//               style: TextStyle(
//                   color: Colors.lightBlueAccent,
//                   fontSize: 30,
//                   fontWeight: FontWeight.w500)),
//           TextField(
//             textAlign: TextAlign.center,
//             decoration: const InputDecoration(
//               labelText: "Enter the New Task",
//             ),
//             onChanged: (val) {
//               newTaskTitle = val;
//             },
//           ),
//           TextButton(
//               onPressed: () {
//                 if (newTaskTitle != null) {
//                   context.read<TasksController>().addTask(newTaskTitle!);
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text('Add',
//                   style: TextStyle(
//                       color: Colors.lightBlueAccent,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w500))),
//         ],
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> with WidgetsBindingObserver {
  String? newTaskTitle;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      _focusNode.requestFocus(); // Refocus when keyboard closes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text('Add Task',
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.w500)),
          TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              labelText: "Enter the New Task",
            ),
            onChanged: (val) {
              newTaskTitle = val;
            },
          ),
          TextButton(
              onPressed: () {
                if (newTaskTitle != null) {
                  // _focusNode.requestFocus();
                  context.read<TasksController>().addTask(newTaskTitle!);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add',
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
