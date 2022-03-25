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
              Padding(
                padding: EdgeInsets.only(left:40),
                  child: Text('Shopping Bag',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily:"Arial",
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black87)),
                ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                //TODO: Change later.
                height: MediaQuery.of(context).size.height *2 /3,
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right:50),
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/nike_blazer_mid_77.png",
                            fit: BoxFit.fitHeight,
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5, top: 15),
                                child: Text('Jordan Delta 2',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black)),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5, top: 10),
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
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    SizedBox(
                      height: 90,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/nike_blazer_mid_77.png",
                            fit: BoxFit.fitHeight,
                          ),
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 5, top: 15),
                                child: Text('Jordan Delta 2',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black)),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5, top: 10),
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
