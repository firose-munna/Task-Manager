import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Title is here"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Title is here"),
          const Text("Date"),
          Row(
            children: [
              Chip(label: Text("New", style: TextStyle(color: Colors.white), ), backgroundColor: Colors.teal,),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.edit_note, color: Colors.teal,)),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_outlined, color: Colors.red,)),

            ],
          )
        ],
      ),
    );
  }
}
