import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  double headerSize = 17;
  double slideItemWidth = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    SizedBox(
                      height: 25,
                      child: Text('Jordan Delta 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: Color(0xff272022))),
                    ),
                    SizedBox(
                      height: 12,
                      child: Text('3000,00 TL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Color(0xff272022))),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: SizedBox(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/nike_blazer_mid_77.png",
                      fit: BoxFit.fitHeight),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xffB20029),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffB20029),
                        ),
                        onPressed: () {},
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff000000).withOpacity(0.77),
                        ),
                        onPressed: () {},
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff000000).withOpacity(0.77),
                        ),
                        onPressed: () {},
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff000000).withOpacity(0.77),
                        ),
                        onPressed: () {},
                        child: null),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 3 / 4, 52),
                    primary: Color(0xff272022),
                  ),
                  child: Text(
                    'Add to bag',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              const Center(
                child: SizedBox(
                  height: 25,
                  child: Text('Suggestions for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black)),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 165,
                child: ListView(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  cacheExtent: 100,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 35,
                            height: 20,
                            margin: const EdgeInsets.only(left: 90),
                            decoration: BoxDecoration(
                              color: const Color(0xff272022),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('99%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Image.asset(
                            "assets/nike_blazer_mid_77.png",
                            fit: BoxFit.scaleDown,
                          ),
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
                    ),
                    const Padding(padding: EdgeInsets.only(left: 30)),
                    SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // const Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            width: 35,
                            height: 20,
                            margin: const EdgeInsets.only(left: 90),
                            decoration: BoxDecoration(
                              color: const Color(0xff272022),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('99%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Image.asset(
                            "assets/nike_blazer_mid_77.png",
                            fit: BoxFit.scaleDown,
                          ),

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
                    ),
                    const Padding(padding: EdgeInsets.only(left: 30)),
                    SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // const Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            width: 35,
                            height: 20,
                            margin: const EdgeInsets.only(left: 90),
                            decoration: BoxDecoration(
                              color: const Color(0xff272022),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('99%',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          Image.asset(
                            "assets/nike_blazer_mid_77.png",
                            fit: BoxFit.scaleDown,
                          ),

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
