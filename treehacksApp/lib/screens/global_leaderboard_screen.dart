import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GlobalLeaderboard extends StatelessWidget {
  static String id = 'global_leaderboard';
  @override
  Widget build(BuildContext context) {
    final title = 'Global Ranking';
    final dbRef = FirebaseDatabase.instance.reference().child("users");
    List<Map<String, dynamic>> lists = [];

    return  Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        endDrawer: AppDrawer(),
        body: Column(
          children: <Widget>[
            Text("Choose Goal ",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 30,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic)),
          DropdownBtn(),
          Expanded(
            child: FutureBuilder(
                future: dbRef.once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    lists.clear();
                    Map<String, dynamic> values = snapshot.data.value;
                    values.forEach((key, values) {
                      lists.add(values);
                    });
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: lists.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Name: " + lists[index]["name"]),
                                Text("Group: " + lists[index]["group"]),
                              ],
                            ),
                          );
                        });
                  }
                  return LinearProgressIndicator();
                }),
          ),
          ]
        ),
      );
  }
}


class DropdownBtn extends StatefulWidget {
  @override
  DropdownBtn({Key key}) : super(key: key);
  _DropdownBtnState createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.lightBlue,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


