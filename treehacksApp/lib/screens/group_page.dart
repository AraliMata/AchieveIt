import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class GroupPage extends StatefulWidget {
  static String id = 'group_page';
  GroupPage({Key key, this.title}) : super(key:key);

  final String title;

  @override
  _GroupPageState createState() => _GroupPageState();

}


class Person {
  final String name;
  final int progress;

  Person(this.name, this.progress);
}

class _GroupPageState extends State<GroupPage> {
  @override

  Widget build(BuildContext context) {
    var data = [
      new Person("Ana", 89),
      new Person("Jason", 56),
      new Person("Hassan", 46)
    ];

    var series = [
      new charts.Series(id: 'Progress',
          data: data,
          domainFn: (Person clickData, _) => clickData.name,
          measureFn: (Person clickData, _) => clickData.progress),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Current goal: "),
            Text('Ana is winning!'),
            Text('Time left: '),
            chartWidget,
          ],
        ),
      ),
    );
  }


}