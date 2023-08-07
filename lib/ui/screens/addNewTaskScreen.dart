import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/bottomNavBaseScreen.dart';
import 'package:taskmanager/ui/screens/newTaskScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

import 'package:taskmanager/ui/widgets/userProfileBanner.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  Future<void> addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _subjectController.text.trim(),
      "description": _descriptionController.text.trim(),
      "status": "New"
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);
    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _subjectController.clear();
      _descriptionController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task added successfully')));
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const NewTaskScreen()), (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Task add failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Material(child: UserProfileBanner()),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: _formkey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Add New Task",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _subjectController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Subject",
                        ),
                        validator: (String? value){
                          if(value?.isEmpty?? true){
                            return "*Enter subject";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Description",
                        ),
                        validator: (String? value){
                          if(value?.isEmpty?? true){
                            return "*Enter description";
                          }
                          return null;
                        },

                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _addNewTaskInProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                if(!_formkey.currentState!.validate()){
                                  return;
                                }
                                addNewTask();
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const BottomNavBaseScreen()), (route) => false);


                              },
                              child: const Text("Add Task", style: TextStyle(fontSize: 16),)),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
