import 'package:comp491/UI/profilePage.dart';
import 'package:flutter/material.dart';

import '../modals/User.dart';
import '../modals/authentication_service.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key, required this.user}) : super(key: key);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xffFFB2C4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 100)),
                ElevatedButton(onPressed: () {
                  var v = context.read<AuthenticationService>().signOut();
                  }
                  ,child: Text("Sign Out"),)
              ],
            ),
          ),
      ),
    );
  }
}
