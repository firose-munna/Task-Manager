import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/taskListModel.dart';


class TaskListTile extends StatefulWidget {
  const TaskListTile({
    super.key, required this.data,
  });
  final TaskData data;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.data.title ?? 'Unknown'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.data.description ?? ''),
          Text(widget.data.createdDate ?? ''),
          Row(
            children: [
              Chip(label: Text(widget.data.status ?? 'New', style: const TextStyle(color: Colors.white), ), backgroundColor: Colors.teal,),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.edit_note, color: Colors.teal,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_outlined, color: Colors.red,)),

            ],
          )
        ],
      ),
    );
  }
}
