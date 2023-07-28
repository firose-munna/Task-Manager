import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/cancelTaskScreen.dart';
import 'package:taskmanager/ui/screens/completedTaskScreen.dart';
import 'package:taskmanager/ui/screens/inProgressTaskScreen.dart';
import 'package:taskmanager/ui/screens/newTaskScreen.dart';



class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({super.key});

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {

  int _seletectedScreenIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CancelTaskScreen(),
    CompletedTaskScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_seletectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seletectedScreenIndex,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey
        ),
        showUnselectedLabels: true,
        selectedItemColor: Colors.teal,
        onTap: (int index){
          _seletectedScreenIndex = index;
          if(mounted){
            setState(() {});
          }
        },

        items:const  [
          BottomNavigationBarItem(icon: Icon(Icons.upcoming), label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.refresh), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Canceled"),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: "Completed"),

        ],
      ),
    );
  }
}
