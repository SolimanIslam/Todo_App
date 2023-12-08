import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/view/screens/add_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
                backgroundColor: Colors.lightBlueAccent,
                child: const Icon(Icons.clear_all_outlined),
                onPressed: () {
                  context.read<TasksController>().clearTodoList();
                }),
          ),
          const Spacer(),
          FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: const AddTaskPage(),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 60, bottom: 30, right: 30, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.list,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "TO-DO List",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${context.watch<TasksController>().numberOfTasks} Tasks",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 30, bottom: 80),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Consumer<TasksController>(
                builder: (context, controller, child) {
                  return ListView.builder(
                      itemCount: controller.numberOfTasks,
                      itemBuilder: (context, index) {
                        final task = controller.getTasks[index];
                        return Dismissible(
                          key: Key(const Uuid().v4()),
                          background: Container(color: Colors.blue.shade700),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              controller
                                  .removeTask(task); // Remove task on swipe
                            }
                          },
                          child: ListTile(
                            onLongPress: () {
                              controller.removeTask(task);
                            },
                            leading: Text(
                              task.taskName,
                              style: TextStyle(
                                  decoration: task.taskStatus
                                      ? TextDecoration.lineThrough
                                      : null),
                            ),
                            trailing: Checkbox(
                              activeColor: Colors.lightBlueAccent,
                              onChanged: (bool? value) {
                                controller.toggleTask(task);
                              },
                              value: task.taskStatus,
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
