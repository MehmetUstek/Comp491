import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp491/view/dbQueries.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/Product.dart';
import 'ProductPage.dart';


class HomePage extends StatefulWidget {
  final String? userUID;

  const HomePage({Key? key, required this.userUID}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  late String? userUID;
  var future;

  @override
  void initState() {
    super.initState();
    future = getAllProducts();
    userUID = widget.userUID;
  }

  final ref = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, backgroundColor: Colors.black, title: Text("Product Finder", style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white, fontSize: 25, ),))),
      body: Center(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: FutureBuilder(
                  future: future,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
                    if (snapshot1.hasError) {
                      // Show error
                      return const Text(
                          "Error Occurred while downloading product data");
                    }
                    if (snapshot1.hasData) {
                      List<Product> products = snapshot1.data;

                      return GridView.builder(
                        cacheExtent: 100,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                          var img1Name = ref.child(
                              'images/' + products[index].image1 + '.png');
                          return Padding(
                            padding: const EdgeInsets.only(top:20),
                            child:FittedBox(
                            // fit: BoxFit.scaleDown,
                            child:
                            OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xfff5f5f5ff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              // backgroundColor: Colors.black12,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          product: products[index],
                                          userUID: userUID,
                                      colorWeight: 0.8,
                                      shapeWeight: 0.2,
                                        )),
                              );
                            },
                            // style: OutlinedButton.styleFrom(
                            //   side: BorderSide(width: 1, color: Colors.transparent)
                            // ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FutureBuilder(
                                    future: img1Name.getDownloadURL(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<dynamic> snapshot1) {
                                      if (snapshot1.hasError) {
                                        // Show error
                                        return const Text(
                                            "Error Occurred while downloading user data");
                                      }
                                      if (snapshot1.hasData) {
                                        return CachedNetworkImage(
                                          imageUrl: snapshot1.data,
                                          placeholder: (context, url) =>
                                          const FittedBox(fit: BoxFit.scaleDown,
                                            child:CircularProgressIndicator(
                                              color: Color(0xffB20029),

                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.scaleDown,
                                          height: 130,
                                        );
                                      } else {
                                        return const FittedBox(fit: BoxFit.scaleDown,
                                          child:CircularProgressIndicator(
                                            color: Color(0xffB20029),

                                          ),
                                        );
                                      }
                                    }),
                                // Image.asset(
                                //   "assets/nike_blazer_mid_77.png",
                                //   fit: BoxFit.scaleDown,
                                //   height: 100,
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 10),
                                  child: SizedBox(
                                    width:120,
                                    height:25,
                                    child:Text(products[index].title,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black)),
                                ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 40, top: 5, bottom: 10),
                                  child: Text(products[index].price + " \$",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: Colors.black45)),
                                ),
                              ],
                            ),
                          ),
                          ),
                          );
                        },
                      );
                    } else {
                      return const FittedBox(fit: BoxFit.scaleDown,
                      child:CircularProgressIndicator(
                        color: Color(0xffB20029),

                      ),
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // ** and here
}
