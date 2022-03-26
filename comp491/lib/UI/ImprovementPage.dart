import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                height: MediaQuery.of(context).size.height * 4 / 7,
                child: ListView(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  scrollDirection: Axis.vertical,
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  shrinkWrap: true,
                  children: <Widget>[
                    Slidable(
                      // key: const ValueKey(0),
                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex:2,
                            //TODO: Write OnPressed.
                            onPressed: null,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete_rounded,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            flex:2,
                            onPressed: null,
                            backgroundColor: Colors.black45,
                            foregroundColor: Colors.white,
                            icon: Icons.close,
                            label: 'Close',
                          ),
                        ],
                      ),
                      child: SizedBox(
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
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: 2,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Text('TOTAL',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87)),
                      Text('3000,00 TL',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87)),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        side: BorderSide(
                            width: 0.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 3 / 4, 30),
                      primary: Color(0xff272022),
                    ),
                    child: const Text(
                      'Continue to payment',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
