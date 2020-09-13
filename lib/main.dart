import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {
    var data = await http.get("http://www.json-generator.com/api/json/get/cfojnoyBnS?indent=2");
    var jsonData = json.decode(data.body);
    List <User> users = [];
    for (var u in jsonData) {
      User user = User(u["index"], u["about"], u["name"], u["picture"], u["gender"], u["company"], u["phone"], u["address"], u["email"]);
      users.add(user);
    }
    return users;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder (
          future: _getUsers(),
          builder: (context, snapshot) {

            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading"),
                )
              );
            }
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile (
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].email),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data[index].picture),
                    ),
                    onTap: () {
                      Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => UserDetails(snapshot.data[index]))
                      );
                    },
                  );
                },
              );
            }
          },
        ),

      ),
    );
  }
}

class UserDetails extends StatelessWidget {

  final User user;

  UserDetails(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: new Container(

        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12
        ),

        child: Center(
          child: new Column(


            children: <Widget>[

              Expanded(
                child: new Container(),
              ),

              CircleAvatar(
                backgroundImage: NetworkImage(user.picture),
              ),

              SizedBox(height: 16),

              Text(user.email),

              SizedBox(height: 16),

              Text(user.gender),

              SizedBox(height: 16),

              Text(user.company),

              SizedBox(height: 16),

              Text(user.phone),

              SizedBox(height: 16),

              Text(user.address),

              SizedBox(height: 16),

              Text(user.about, textAlign: TextAlign.center),

              SizedBox(height: 16),

              Expanded(
                child: new Container(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class User {
  final int index;
  final String about;
  final String name;
  final String picture;
  final String gender;
  final String company;
  final String phone;
  final String address;
  final String email;

  User(this.index, this.about, this.name, this.picture, this.gender,
      this.company, this.phone, this.address, this.email);

}
