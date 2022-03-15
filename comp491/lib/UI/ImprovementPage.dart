import 'package:comp491/modals/User.dart';
import 'package:flutter/material.dart';

class ImprovementPage extends StatefulWidget {
  final String? userUID;

  const ImprovementPage({
    Key? key,
    required this.userUID,
  }) : super(key: key);

  @override
  _ImprovementPage createState() => _ImprovementPage(userUID);
}

class _ImprovementPage extends State<ImprovementPage> {
  late String? userUID;

  _ImprovementPage(String? _userUID) {
    userUID = _userUID;
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
