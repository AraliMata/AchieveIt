import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GlobalLeaderboard extends StatelessWidget {
  static String id = 'global_leaderboard';
  @override
  Widget build(BuildContext context) {
    final title = 'Global Ranking';
    final items = List<String>.generate(10000, (i) => "Item $i");

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        endDrawer: AppDrawer(),
        body: Column(
          children: <Widget>[
          Text("Choose Goal"),
          DropdownBtn(),
          Expanded(
            child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}'),
              );
             },
            ),
          ),
          ]
        ),
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
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
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


