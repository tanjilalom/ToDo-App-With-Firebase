import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateTaskAlertDialog extends StatefulWidget {
  final String taskId, taskName, taskDesc;

   const UpdateTaskAlertDialog(
      {Key? Key,
      required this.taskId,
      required this.taskName,
      required this.taskDesc})
      : super(key: Key);

  @override
  State<UpdateTaskAlertDialog> createState() => _UpdateTaskAlertDialogState();
}

class _UpdateTaskAlertDialogState extends State<UpdateTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    taskNameController.text = widget.taskName;
    taskDescController.text = widget.taskDesc;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskNameController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.square_list,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right,
                      color: Colors.brown),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            _updateTasks(
              taskName,
              taskDesc,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }

  Future _updateTasks(String taskName, String taskDesc) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection
        .doc(widget.taskId)
        .update({
          'taskName': taskName,
          'taskDesc': taskDesc,
        })
        .then(
          (_) => Get.snackbar('Update', 'Task updated successfully'),
        )
        .catchError(
          (error) => Get.snackbar('Update', 'Failed'),
        );
  }
}
