import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/group_page.dart';
import 'package:treehacksApp/screens/global_leaderboard_screen.dart';
import 'package:treehacksApp/screens/goal_screen.dart';
class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: new Text("Menu"),
          ),
          new ListTile(
            title: new Text("Group"),
            onTap: (){
              Navigator.pushNamed(context, GroupPage.id);
            },
          ),
          new ListTile(
            title: new Text("Set new goal"),
            onTap: (){
              Navigator.pushNamed(context, GoalScreen.id);
            },
          ),
          new ListTile(
            title: new Text("Register Activity"),
          ),
          new ListTile(
            title: new Text("Global Rankings"),
            onTap: (){
              Navigator.pushNamed(context, GlobalLeaderboard.id);
            },
          ),
          new ListTile(
            title: new Text("Settings"),
          ),
        ],
      ),
    );
  }
}
