import 'package:attendance_tracker/components/add_sheet.dart';
import 'package:flutter/material.dart';

class AddSubjectFab extends StatelessWidget {
  const AddSubjectFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext cont) {
              return const AddSubjectSheet();
            });
      },
      tooltip: 'Add New Subject',
      elevation: 0,
      child: const Icon(Icons.add),
    );
  }
}
