import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteTaskDialog extends StatefulWidget {
  final String taskId, taskName;

  const DeleteTaskDialog(
      {super.key, required this.taskId, required this.taskName});

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Delete Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: <Widget>[
              const Text(
                'Are you sure you want to delete this task?',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Text(
                widget.taskName.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
            _deleteTasks();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Future _deleteTasks() async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection
        .doc(widget.taskId)
        .delete()
        .then(
          (_) => Get.snackbar('Delete', 'Task deleted successfully'),
        )
        .catchError(
          (error) => Get.snackbar('Delete', 'Failed'),
        );
  }
}

// final collection = FirebaseFirestore.instance.collection('collection');
// collection
//     .doc('some_id') // <-- Doc ID to be deleted.
// .delete() // <-- Delete
//     .then((_) => print('Deleted'))
// .catchError((error) => print('Delete failed: $error'));
