import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/app_drawer.dart';

class GlobalLeaderboard extends StatelessWidget {
  static String id = 'global_leaderboard';
  @override
  Widget build(BuildContext context) {
    final title = 'Global Ranking';
    final dbRef = FirebaseDatabase.instance.reference();
    final makeCall = MakeCall();


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
            FutureBuilder(

                future: makeCall.firebaseCalls(dbRef), // async work
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting: return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                    return new ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot.data[index].name),
                                Text(snapshot.data[index].groups),
                                Text(snapshot.data[index].goals),
                                Text(snapshot.data[index].progress),
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
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

  User({this.name, this.groups, this.goals, this.progress});

  factory User.fromJson(Map<dynamic,dynamic> parsedJson) {
    return User(name:parsedJson['name'],groups: parsedJson['groups'],goals:parsedJson['Goals'], progress: parsedJson['progress']['Goal1']);
  }
}

class UserList{
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


