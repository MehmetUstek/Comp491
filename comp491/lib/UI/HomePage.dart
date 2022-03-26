import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ProductPage.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 100),
              child: GridView.count(
                crossAxisCount: 2,

                childAspectRatio: 0.8,
                crossAxisSpacing: 30,

                // For real builder:
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   childAspectRatio: 0.8,
                //   crossAxisSpacing: 30,
                // ),
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,

                physics: const ScrollPhysics(),
                padding: const EdgeInsets.only(top: 5.0),
                // itemBuilder: (BuildContext context, int index) {  },
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProductPage()),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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

                  // Padding(padding: EdgeInsets.only(left:10)),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/nike_blazer_mid_77.png",
                          fit: BoxFit.scaleDown,
                          height: 100,
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
          ),
        ),
      ),
    );
  }
}
