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
  double slideItemWidth = 80;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color(0xffFFB2C4),
          width: MediaQuery.of(context).size.width,
          // margin: EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 100)),
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
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white)),
                    ),
                    SizedBox(
                      height: 12,
                      child: Text('3000,00 TL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.white)),
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

                children:  <Widget> [
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xffF891A9),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Colors.white,
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Colors.white,
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Colors.white,
                  ),

                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              const Center(
                child:
                SizedBox(
                  height: 25,
                  child: Text('Suggestions for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.white)),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),

              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 165,
                child: SizedBox(
                  height: 130,
                  width: MediaQuery.of(context).size.width,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
