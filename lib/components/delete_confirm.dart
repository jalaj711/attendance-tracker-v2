import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog(
      {super.key, required this.message, required this.onDelete});
  final String message;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Confirmation'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Yes');
            onDelete();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
