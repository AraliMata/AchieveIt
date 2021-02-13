import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GoalScreen extends StatefulWidget {
  static String id = 'goal_screen';
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {

  @override

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group"),
      ),
      endDrawer: AppDrawer(),

      body: Center(
        child: Column(
          children: [
            Text("Ser new goals"),
            Text("How long?"),
            TextField(
            controller: myController,
            ),
            Text("Target amount"),
            TextField(
              controller: myController2,
            ),
            Text("Group"),
        ],
        ),
      )
    );
  }
}
