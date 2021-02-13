import 'package:flutter/material.dart';
class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: FractionalOffset.centerRight,
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Icon(Icons.navigate_next),
            new Icon(Icons.close),
            new Text ("More items..")
          ],
        ),
        color: Colors.blue,
        height: 700.0,
        width: 200.0,
      ),
    );
  }
}
