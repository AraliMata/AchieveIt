import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GlobalLeaderboard extends StatelessWidget {
  static String id = 'global_leaderboard';
  @override
  Widget build(BuildContext context) {
    final title = 'Global Ranking';
    final dbRef = FirebaseDatabase.instance.reference();
    //final makeCall = MakeCall();

    final user1 = User("Ana", ["Best friends", "Developers"], "Run 20 km", 90);
    final user2 = User("Jason", ["Group1"], "Run 10 km", 45);
    final user3 = User("Hassan", ["Group1","Best friends"], "Run 5 km", 43);

    final List<User>  users = <User>[user1, user2, user3];

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
            child:
            ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 80,
                  child: Column(
                      children: <Widget>[
                  Text('${users[index].name}'),
                        Text('Groups ${users[index].groups}'),
                        Text('Goal: ${users[index].goals}'),
                        Text('Progress: ${users[index].progress}')

                  ]
                )
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
          )
          ]
        ),
      );
  }
}

class User{
  String name;
  List<String> groups;
  String goals;
  int progress;

  User(name, groups, goals, progress) {
    this.name = name;
    this.groups = groups;
    this.goals = goals;
    this.progress = progress;
  }


  /*factory User.fromJson(Map<dynamic,dynamic> parsedJson) {
    return User(name:parsedJson['name'],groups: parsedJson['groups'],goals:parsedJson['Goals'], progress: parsedJson['progress']['Goal1']);
  }*/
}

/*class UserList{
  List<User> userList;

  UserList({this.userList});


  static List<User> parseusers(userJSON){
    var rList=userJSON['users'] as List;
    List<User> userList=rList.map((data) => User.fromJson(data)).toList();  //Add this
    return userList;

  }

  factory UserList.fromJSON(Map<dynamic, dynamic> json){
    return UserList(
      userList: parseusers(json)
    );
  }
}

class MakeCall{
  List<User> listItems=[];

  Future<List<User>> firebaseCalls (DatabaseReference databaseReference) async{
    UserList userList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse=dataSnapshot.value;
    userList = UserList.fromJSON(jsonResponse);
    listItems.addAll(userList.userList);

    return listItems;
  }
}*/


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


