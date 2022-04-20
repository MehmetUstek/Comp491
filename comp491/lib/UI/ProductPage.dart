import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modals/Product.dart';
import '../modals/dbQueries.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final String? userUID;

  const ProductPage({Key? key, required this.product, required this.userUID})
      : super(key: key);

  @override
  _ProductPage createState() => _ProductPage();
}

enum OptionChecked { first, second, third, fourth }

class _ProductPage extends State<ProductPage> {
  late Product product;
  late String? userUID;
  var img1Name;
  var img2Name;
  var img3Name;
  var img4Name;
  var future;
  var temp1;
  var temp2;
  var temp3;
  var temp4;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    userUID = widget.userUID;
    img1Name = ref.child('images/' + product.image1 + '.png');
    img2Name = ref.child('images/' + product.image2 + '.png');
    img3Name = ref.child('images/' + product.image3 + '.png');
    img4Name = ref.child('images/' + product.image4 + '.png');
    future = img1Name.getDownloadURL();

    temp1 = ref.child('images/image97sub1.png').getDownloadURL();
    temp2 = ref.child('images/image102sub1.png').getDownloadURL();
    temp3 = ref.child('images/image103sub1.png').getDownloadURL();
    temp4 = ref.child('images/image104sub1.png').getDownloadURL();
  }

  final ref = FirebaseStorage.instance.ref();

  Color tickedColor = const Color(0xffB20029);
  Color untickedColor = const Color(0xff000000).withOpacity(0.77);
  Color radio1 = const Color(0xffB20029);
  Color radio2 = const Color(0xff000000).withOpacity(0.77);
  Color radio3 = const Color(0xff000000).withOpacity(0.77);
  Color radio4 = const Color(0xff000000).withOpacity(0.77);
  OptionChecked? _optionChecked = OptionChecked.first;

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
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                      child: Text(product.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              color: Color(0xff272022))),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(product.price + " \$",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
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
                  child: FutureBuilder(
                      future: future,
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
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.scaleDown,
                            height: 100,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
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
                        // RadioListTile(value: OptionChecked.first, onChanged: (OptionChecked? value) {
                        //   setState(() {
                        //     _optionChecked = value;
                        //   });
                        // }, groupValue: _optionChecked
                        style: ElevatedButton.styleFrom(
                          primary: radio1,
                        ),
                        onPressed: () {
                          setState(() {
                            _optionChecked = OptionChecked.first;
                            radio1 = tickedColor;
                            radio2 = untickedColor;
                            radio3 = untickedColor;
                            radio4 = untickedColor;
                            future = img1Name.getDownloadURL();
                          });
                        },
                        child: null),
                    // ),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio2,
                        ),
                        onPressed: () {
                          setState(() {
                            _optionChecked = OptionChecked.second;
                            radio1 = untickedColor;
                            radio2 = tickedColor;
                            radio3 = untickedColor;
                            radio4 = untickedColor;
                            future = img2Name.getDownloadURL();
                          });
                        },
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio3,
                        ),
                        onPressed: () {
                          setState(() {
                            _optionChecked = OptionChecked.third;
                            radio1 = untickedColor;
                            radio2 = untickedColor;
                            radio3 = tickedColor;
                            radio4 = untickedColor;
                            future = img3Name.getDownloadURL();
                          });
                        },
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio4,
                        ),
                        onPressed: () {
                          setState(() {
                            _optionChecked = OptionChecked.fourth;
                            radio1 = untickedColor;
                            radio2 = untickedColor;
                            radio3 = untickedColor;
                            radio4 = tickedColor;
                            future = img4Name.getDownloadURL();
                          });
                        },
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
                  onPressed: () {
                    addToUserBagByUserUIDandPid(userUID, product.productId);
                  },
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
                child: FutureBuilder(
                    future: getSuggestedProductsByPid("0"),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Product>> snapshotSuggestions) {
                      if (snapshotSuggestions.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshotSuggestions.hasData) {
                        List<Product>? products = snapshotSuggestions.data;
                        return ListView(
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
                                  FutureBuilder(
                                      future: temp3,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic>
                                              snapshot_temp) {
                                        if (snapshot_temp.hasError) {
                                          // Show error
                                          return const Text(
                                              "Error Occurred while downloading user data");
                                        }
                                        if (snapshot_temp.hasData) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot_temp.data,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.scaleDown,
                                            height: 80,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 15),
                                    child: Text('Nike SB Shane',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 10),
                                    child: Text('85 \$',
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
                                      child: Text('92%',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 11,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: temp4,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic>
                                              snapshot_temp) {
                                        if (snapshot_temp.hasError) {
                                          // Show error
                                          return const Text(
                                              "Error Occurred while downloading user data");
                                        }
                                        if (snapshot_temp.hasData) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot_temp.data,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.scaleDown,
                                            height: 80,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),

                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 15),
                                    child: Text('Jordan Air NFH',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 10),
                                    child: Text('110 \$',
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
                                      child: Text('85%',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 11,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  FutureBuilder(
                                      future: temp2,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic>
                                              snapshot_temp) {
                                        if (snapshot_temp.hasError) {
                                          // Show error
                                          return const Text(
                                              "Error Occurred while downloading user data");
                                        }
                                        if (snapshot_temp.hasData) {
                                          return CachedNetworkImage(
                                            imageUrl: snapshot_temp.data,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.scaleDown,
                                            height: 80,
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      }),

                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 15),
                                    child: Text('Nike Run Swift 2',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: Colors.black)),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5, top: 10),
                                    child: Text('70 \$',
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
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
