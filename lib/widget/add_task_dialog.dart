import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskAlertDialog extends StatefulWidget {
  const AddTaskAlertDialog({
    super.key,
  });

  @override
  State<AddTaskAlertDialog> createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return AlertDialog(
      scrollable: true,
      title: const Text(
        'New Task',
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
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
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
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
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
            Navigator.of(context, rootNavigator: true)
                .pop(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;

            if (taskName.isNotEmpty && taskDesc.isNotEmpty) {
              try {
                await _addTasks(taskName: taskName, taskDesc: taskDesc);
                Navigator.of(context).pop(); // Close the dialog
              } catch (e) {
                // Show an error dialog if Firebase operation fails
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content:
                          const Text('Failed to save task. Please try again.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              // Show error if fields are empty
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: const Text(
                        'Task name and description cannot be empty.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _addTasks(
      {required String taskName, required String taskDesc}) async {
    try {
      // Add a new document with task name and description
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('tasks').add({
        'taskName': taskName,
        'taskDesc': taskDesc,
        'createdAt':
            FieldValue.serverTimestamp(), // Add a timestamp field to avoid null
      });

      // Update document with the task ID
      String taskId = docRef.id;
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(taskId)
          .update({'id': taskId});

      // Clear the form fields after successful addition
      _clearAll();

      print('Task added successfully');
    } catch (e) {
      print('Error adding task: $e'); // Log the error
      throw e; // Optionally rethrow to handle in the UI
    }
  }

  void _clearAll() {
    taskNameController.clear();
    taskDescController.clear();
  }

  @override
  void dispose() {
    // Dispose controllers when no longer needed to free up resources
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
  }
}
