import 'package:comp491/modals/dbQueries.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../modals/Product.dart';
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
  final ref = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 100),
              child: FutureBuilder(
                  future: getAllProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic>
                      snapshot1) {
                    if (snapshot1.hasError) {
                      // Show error
                      return const Text(
                          "Error Occurred while downloading product data");
                    }
                    if (snapshot1.hasData) {
                      List<Product> products = snapshot1.data;

                      return GridView.builder(
                        // crossAxisCount: 2,
                        // childAspectRatio: 0.8,
                        // crossAxisSpacing: 30,

                        // For real builder:
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 30,
                        ),
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.vertical,

                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.only(top: 5.0),
                        // itemBuilder: (BuildContext context, int index) {  },
                        itemBuilder: (BuildContext context, int index) {
                          var img1Name = ref
                              .child('images/' + products[index].image1 + '.png');
                          return OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(product: products[index],)),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                    future: img1Name.getDownloadURL(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic>
                                        snapshot1) {
                                      if (snapshot1.hasError) {
                                        // Show error
                                        return const Text(
                                            "Error Occurred while downloading user data");
                                      }
                                      if (snapshot1.hasData) {
                                        return Image.network(
                                            snapshot1.data,
                                            fit: BoxFit.scaleDown,
                                        height: 100,);
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }),
                                // Image.asset(
                                //   "assets/nike_blazer_mid_77.png",
                                //   fit: BoxFit.scaleDown,
                                //   height: 100,
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, top: 15),
                                  child: Text(products[index].title,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, top: 10),
                                  child: Text(products[index].price+" \$",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.black45)),
                                ),
                              ],
                            ),
                          );
                        },

                      );
                    }
                    else {
                      return const CircularProgressIndicator(color: const Color(0xffB20029),);
                    }
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
