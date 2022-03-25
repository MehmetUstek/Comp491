import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImprovementPage extends StatefulWidget {
  const ImprovementPage({Key? key}) : super(key: key);

  @override
  _ImprovementPage createState() => _ImprovementPage();
}

class _ImprovementPage extends State<ImprovementPage> {
  @override
  void initState() {
    super.initState();
  }

  double headerSize = 17;
  double slideItemWidth = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 100)),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text('Shopping Bag',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Arial",
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.black87)),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                //TODO: Change later.
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: ListView(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      // width: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(
                            color: Colors.black12,
                          ),
                        ),
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset(
                                "assets/nike_blazer_mid_77.png",
                                fit: BoxFit.fitHeight,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Jordan Delta 2',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black)),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text('3000,00 TL',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13,
                                            color: Colors.black45)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
