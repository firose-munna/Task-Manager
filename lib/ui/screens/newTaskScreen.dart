import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/addNewTaskScreen.dart';
import 'package:taskmanager/ui/widgets/iteamCard.dart';
import 'package:taskmanager/ui/widgets/summaryCard.dart';
import 'package:taskmanager/ui/widgets/taskListTile.dart';
import 'package:taskmanager/ui/widgets/userProfileBanner.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            const UserProfileBanner(),

            const Row(
              children: [
                Expanded(
                    child: SummeryCard(
                  number: 12,
                  title: 'New',
                )),
                Expanded(
                    child: SummeryCard(
                  number: 15,
                  title: 'In Progress',
                )),
                Expanded(
                    child: SummeryCard(
                  number: 9,
                  title: 'Cancel',
                )),
                Expanded(
                    child: SummeryCard(
                  number: 125,
                  title: 'Completed',
                )),
              ],
            ),
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

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));
        },
      ),
    );
  }
}



