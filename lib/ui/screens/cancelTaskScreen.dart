import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/iteamCard.dart';
import 'package:taskmanager/ui/widgets/taskListTile.dart';
import 'package:taskmanager/ui/widgets/userProfileBanner.dart';

class CancelTaskScreen extends StatelessWidget {
  const CancelTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            const UserProfileBanner(),

            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        child: TaskListTile(),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
