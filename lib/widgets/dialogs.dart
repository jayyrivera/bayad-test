import 'package:flutter/material.dart';

Future<int> showDeleteConfirmDialog(BuildContext context) async {
  // Show dialog returns the value of Navigator.pop
  return await showDialog(
    context: context,
    barrierDismissible: false, // User must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this movie?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context)
                  .pop(0); // Dismisses the dialog and returns 0
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context)
                  .pop(1); // Dismisses the dialog and returns 1
            },
          ),
        ],
      );
    },
  );
}
