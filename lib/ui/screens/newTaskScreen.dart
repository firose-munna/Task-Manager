import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/model/summaryCountModel.dart';
import 'package:taskmanager/data/model/taskListModel.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/addNewTaskScreen.dart';
import 'package:taskmanager/ui/widgets/iteamCard.dart';
import 'package:taskmanager/ui/widgets/summaryCard.dart';
import 'package:taskmanager/ui/widgets/taskListTile.dart';
import 'package:taskmanager/ui/widgets/userProfileBanner.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('get new task data failed')));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.newTasks);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [

            const UserProfileBanner(),

            _getCountSummaryInProgress
                ? const LinearProgressIndicator()
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child:Row(
                children: [
                  Expanded(
                      child: SummeryCard(
                        number: _summaryCountModel.data![0].sum ?? 0,
                        title: _summaryCountModel.data![0].sId ?? 'New',
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
            ),
            // SizedBox(
            //   height: 70,
            //   width: double.infinity,
            //   child: ListView.separated(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: _summaryCountModel.data?.length ?? 0,
            //     itemBuilder: (context, index) {
            //       return SummeryCard(
            //         title: _summaryCountModel.data![index].sId ?? 'New',
            //         number: _summaryCountModel.data![index].sum ?? 0,
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return const Divider(
            //         height: 4,
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  getNewTasks();
                },
                child: _getNewTaskInProgress
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  itemCount: _taskListModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ItemCard(
                      child: TaskListTile(
                        data: _taskListModel.data![index],
                      ),
                    );
                  },
                ),
              ),
            ),

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



