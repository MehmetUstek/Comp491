import 'package:comp491/UI/profilePage.dart';
import 'package:flutter/material.dart';

import '../modals/User.dart';

class ProfileTab extends StatefulWidget {
  ProfileTab({Key? key, required this.user}) : super(key: key);
  final UserData? user;

  @override
  _ProfileTab createState() => _ProfileTab(user!);
}

class _ProfileTab extends State<ProfileTab> {
  late UserData user;

  _ProfileTab(UserData _user) {
    this.user = _user;
  }

  @override
  void initState() {
    super.initState();
  }

  double headerSize = 17;

  Gradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
    stops: [
      0.5,
      0.9,
    ],
    colors: [
      Color(0xffA9C7F2),
      Color(0xff8DB5EE),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                stops: [
                  0.5,
                  0.9,
                ],
                colors: [
                  Color(0xffA9C7F2),
                  Color(0xff8DB5EE),
                ],
              )),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 100)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Color(0xffE4EDFB),
                          style: BorderStyle.solid),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Color(0xffE4EDFB),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Premium Account',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("images/crown.png"),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                // Edit Profile:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    alignment: Alignment.centerLeft,
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Color(0xffE4EDFB),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                            user: user,
                          )),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Color(0xffE4EDFB),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Change Colors',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("images/crown.png"),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Color(0xffE4EDFB),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Custom Feelins',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("images/crown.png"),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Color(0xffE4EDFB),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Add new category',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset("images/crown.png"),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
