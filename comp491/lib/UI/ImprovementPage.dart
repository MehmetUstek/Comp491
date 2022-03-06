import 'package:comp491/modals/User.dart';
import 'package:flutter/material.dart';

class ImprovementPage extends StatefulWidget {
  final UserData? user;

  const ImprovementPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ImprovementPage createState() => _ImprovementPage(user!);
}

class _ImprovementPage extends State<ImprovementPage> {
  late UserData user;

  _ImprovementPage(UserData _user) {
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
          decoration: const BoxDecoration(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
