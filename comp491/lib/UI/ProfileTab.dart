import 'package:comp491/UI/profilePage.dart';
import 'package:flutter/material.dart';

import '../view/User.dart';
import '../view/authentication_service.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key, required this.userUID}) : super(key: key);
  final String? userUID;

  @override
  _ProfileTab createState() => _ProfileTab(userUID!);
}

class _ProfileTab extends State<ProfileTab> {
  late String userUID;
  var padding = const EdgeInsets.only(top: 20);

  _ProfileTab(String _userUID) {
    this.userUID = _userUID;
  }


  @override
  void initState() {
    super.initState();
  }

  double headerSize = 17;


  @override
  Widget build(BuildContext context) {
    var style =  ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        side: BorderSide(
            width: 0.0,
            color: Colors.white,
            style: BorderStyle.solid),
      ),
      fixedSize:
      Size(MediaQuery.of(context).size.width *7/8, 52),
      primary: Colors.black54,
    );
    return Scaffold(
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 100)),

                Padding(
                  padding: padding,
                  child: Center(
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ProfilePage(userUID: userUID,)),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: padding,
                  child: Center(
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        'Lorem Ipsum',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: padding,
                  child: Center(
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        'Lorem Ipsum',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: padding,
                  child: Center(
                  child: ElevatedButton(onPressed: () {
                    var v = context.read<AuthenticationService>().signOut();

                  }
                  ,
                      style: style
                    ,child: Text("Sign Out"),),

                )
                ),
              ],
            ),
          ),
      ),
    );
  }
}
