
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
            color: Colors.orange,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 100)),
                  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 2,
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                        width: 110,
                        child: TextButton(
                          //TODO: Change later.

                          onPressed: () {},
                          style: TextButton.styleFrom(
                              fixedSize: Size(
                                  MediaQuery.of(context).size.width * 2 / 3,
                                  20),
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 2 / 3,
                                  20)),
                          child: Text('How do you feel',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white)),
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.angleDown,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: // Surround with an elevated button.
                        Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                          },
                          child: Text('Your Day',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: headerSize,
                                  color: Colors.white)),
                        ),
                        IconButton(
                            onPressed: () {
                            },
                            icon: Icon(
                              CupertinoIcons.right_chevron,
                              color: Colors.white,
                            ))
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
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
                      primary: Color(0xff43BC64),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Coffee with Jennifer',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Text(
                          '5 / 10',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(
                        side: BorderSide(
                            width: 0.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      fixedSize: Size(MediaQuery.of(context).size.width, 45),
                      primary: Color(0xff9D4CFA),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Study for 4 hours.',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Text(
                          '5 / 10',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  TextButton.icon(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 27,
                    ),
                    label: Text('Add new experience',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  SizedBox(
                    height: 25,
                    child: Text('Accept',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: headerSize,
                            color: Colors.white)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      shrinkWrap: true,
                      primary: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 5.0),
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            fixedSize: Size(50, 20),
                          ),
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: Text(
                            "",
                            style: TextStyle(fontSize: 0),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            fixedSize: Size(50, 20),
                          ),
                          child: Text(
                            "Your Surroundings",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            fixedSize: Size(50, 20),
                          ),
                          child: Text(
                            "Your Surroundings",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            fixedSize: Size(50, 20),
                          ),
                          child: Text(
                            "Your Surroundings",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
