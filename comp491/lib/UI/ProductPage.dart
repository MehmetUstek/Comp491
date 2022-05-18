import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp491/UI/ProductWeights.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../view/Product.dart';
import '../view/dbQueries.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final String? userUID;

  final double? colorWeight;

  final double? shapeWeight;

  const ProductPage({Key? key, required this.product, required this.userUID, this.colorWeight, this.shapeWeight})
      : super(key: key);

  @override
  _ProductPage createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
  late Product product;
  late String? userUID;
  late double? colorWeight;
  late double? shapeWeight;
  var img1Name;
  var img2Name;
  var img3Name;
  var img4Name;
  var img1dUrl;
  var img2dUrl;
  var img3dUrl;
  var img4dUrl;
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
    colorWeight = widget.colorWeight;
    shapeWeight = widget.shapeWeight;
    img1Name = ref.child('images/' + product.image1 + '.png');
    img2Name = ref.child('images/' + product.image2 + '.png');
    img3Name = ref.child('images/' + product.image3 + '.png');
    img4Name = ref.child('images/' + product.image4 + '.png');
    img1dUrl = img1Name.getDownloadURL();
    img2dUrl = img2Name.getDownloadURL();
    img3dUrl = img3Name.getDownloadURL();
    img4dUrl = img4Name.getDownloadURL();
    future = img1dUrl;
  }

  final ref = FirebaseStorage.instance.ref();

  Color tickedColor = const Color(0xffB20029);
  Color untickedColor = const Color(0xff000000).withOpacity(0.77);
  Color radio1 = const Color(0xffB20029);
  Color radio2 = const Color(0xff000000).withOpacity(0.77);
  Color radio3 = const Color(0xff000000).withOpacity(0.77);
  Color radio4 = const Color(0xff000000).withOpacity(0.77);

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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20)),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 22,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(product.title,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: Color(0xff272022))),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                      child: Text(product.price + " \$",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Color(0xff272022))),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
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
                            placeholder: (context, url) => const FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CircularProgressIndicator(
                                color: Color(0xffB20029),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.scaleDown,
                            height: 100,
                          );
                        } else {
                          return const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CircularProgressIndicator(
                              color: Color(0xffB20029),
                            ),
                          );
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
                    color: const Color(0xffB20029),
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
                            radio1 = tickedColor;
                            radio2 = untickedColor;
                            radio3 = untickedColor;
                            radio4 = untickedColor;
                            future = img1dUrl;
                          });
                        },
                        child: null),
                    // ),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: const Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio2,
                        ),
                        onPressed: () {
                          setState(() {
                            radio1 = untickedColor;
                            radio2 = tickedColor;
                            radio3 = untickedColor;
                            radio4 = untickedColor;
                            future = img2dUrl;
                          });
                        },
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: const Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio3,
                        ),
                        onPressed: () {
                          setState(() {
                            radio1 = untickedColor;
                            radio2 = untickedColor;
                            radio3 = tickedColor;
                            radio4 = untickedColor;
                            future = img3dUrl;
                          });
                        },
                        child: null),
                  ),
                  Container(
                    width: slideItemWidth,
                    height: 10,
                    color: const Color(0xff000000).withOpacity(0.77),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: radio4,
                        ),
                        onPressed: () {
                          setState(() {
                            radio1 = untickedColor;
                            radio2 = untickedColor;
                            radio3 = untickedColor;
                            radio4 = tickedColor;
                            future = img4dUrl;
                          });
                        },
                        child: null),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Center(
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
                        Size(MediaQuery.of(context).size.width * 3 / 4, 52),
                    primary: const Color(0xff272022),
                  ),
                  child: const Text(
                    'Add to bag',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {
                    addToUserBagByUserUIDandPid(userUID, product.productId);
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Center(
                child: SizedBox(
                  height: 45,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    TextButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductWeights(
                              product: product,
                              userUID: userUID,
                            )),
                      );
                    }, child:
                    const Text('Product Preferences',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black)),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductWeights(
                                  product: product,
                                  userUID: userUID,
                                )),
                          );
                        }, icon: const Icon(Icons.chevron_right))
                  ]),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
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
                height: 180,
                child: FutureBuilder(
                    future:
                        getSuggestedProductsByPid(product.productId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Product>> snapshotSuggestions) {
                      if (snapshotSuggestions.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshotSuggestions.hasData) {
                        List<Product>? products = snapshotSuggestions.data;

                        return ListView.builder(
                            padding: const EdgeInsets.only(left: 10),
                            scrollDirection: Axis.horizontal,
                            addAutomaticKeepAlives: false,
                            cacheExtent: 100,
                            itemCount: products?.length,
                            itemBuilder: (BuildContext context, int index) {
                              Product productSuggested = products![index];
                              var imgName = ref.child(
                                  'images/' + productSuggested.image1 + '.png');
                              return OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductPage(
                                              product: productSuggested,
                                              userUID: userUID,
                                            )),
                                  );
                                },
                                child: SizedBox(
                                  // height: 70,
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 35,
                                        height: 20,
                                        margin: const EdgeInsets.only(left: 90),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff272022),
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                          future: imgName.getDownloadURL(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic>
                                                  snapshotTemp) {
                                            if (snapshotTemp.hasError) {
                                              // Show error
                                              return const Text(
                                                  "Error Occurred while downloading user data");
                                            }
                                            if (snapshotTemp.hasData) {
                                              return CachedNetworkImage(
                                                imageUrl: snapshotTemp.data,
                                                placeholder: (context, url) =>
                                                    const FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color(0xffB20029),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.scaleDown,
                                                height: 80,
                                              );
                                            } else {
                                              return const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Color(0xffB20029),
                                                ),
                                              );
                                            }
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 15),
                                        child: Text(
                                          productSuggested.title,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12,
                                              color: Colors.black),
                                          // maxLines: 1
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 10),
                                        child: Text(
                                            productSuggested.price + ' \$',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                                color: Colors.black45)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: CircularProgressIndicator(
                            color: Color(0xffB20029),
                          ),
                        );
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
