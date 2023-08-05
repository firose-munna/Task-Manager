import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/taskListModel.dart';


class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTab, onEditTab;
  const TaskListTile({
    super.key, required this.data, required this.onDeleteTab, required this.onEditTab,
  });
  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.description ?? ''),
          Text(data.createdDate ?? ''),
          Row(
            children: [
              Chip(label: Text(data.status ?? 'New', style: const TextStyle(color: Colors.white), ), backgroundColor: Colors.teal,),
              const Spacer(),
              IconButton(onPressed: onEditTab, icon: const Icon(Icons.edit_note, color: Colors.teal,)),
              IconButton(onPressed: onDeleteTab, icon: const Icon(Icons.delete_forever_outlined, color: Colors.red,)),

            ],
          )
        ],
      ),
    );
  }
}
