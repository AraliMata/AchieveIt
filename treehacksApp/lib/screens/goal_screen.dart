import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GoalScreen extends StatefulWidget {
  static String id = 'goal_screen';

  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Goals"),
      ),
      endDrawer: AppDrawer(),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Set New Goal ",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontStyle: FontStyle.italic)),
                  RegisterGoal(),
                ]),
          )),
    );
  }
}


class RegisterGoal extends StatefulWidget {
  RegisterGoal({Key key}) : super(key: key);

  @override
  _RegisterGoalState createState() => _RegisterGoalState();
}

class _RegisterGoalState extends State<RegisterGoal> {
  final _formKey = GlobalKey<FormState>();
  final listOfGoals = ["Goal1", "Goal2", "Goal3"];
  String dropdownValue = 'Goal1';
  final durationController = TextEditingController();
  final targetController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("goals");

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: durationController,
                  decoration: InputDecoration(
                    labelText: "Enter duration",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter duration';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: targetController,
                  decoration: InputDecoration(
                    labelText: "Enter Target Amount",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Target Amount';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: DropdownButtonFormField(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  decoration: InputDecoration(
                    labelText: "Select Group",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: listOfGoals.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Select Group';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            dbRef.push().set({
                              "duration": durationController.text,
                              "target": targetController.text,
                              "name": dropdownValue
                            }).then((_) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Successfully Added')));
                              targetController.clear();
                              durationController.clear();
                            }).catchError((onError) {
                              Scaffold.of(context)
                                  .showSnackBar(SnackBar(content: Text(onError)));
                            });
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  )),
            ])));
  }

  @override
  void dispose() {
    super.dispose();
    targetController.dispose();
    durationController.dispose();
  }
}
