import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../view/Product.dart';
import '../view/dbQueries.dart';
import 'ProductPage.dart';

class ProductWeights extends StatefulWidget {
  final Product product;
  final String? userUID;

  const ProductWeights({Key? key, required this.product, required this.userUID})
      : super(key: key);

  @override
  _ProductWeights createState() => _ProductWeights();
}

class _ProductWeights extends State<ProductWeights> {
  late Product product;
  late String? userUID;
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
  double _currentSliderValue = 20;
  double _currentSliderValueShape = 20;

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
                    color: Color(0xff000000).withOpacity(0.77),
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
              const Padding(padding: EdgeInsets.only(top: 80)),
              const Center(
                child: SizedBox(
                  height: 45,
                  child: Text('Product Preferences',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black)),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 25),
              child:
              SizedBox(
                height: 22,
                child: Text("Color",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color(0xff272022))),
              ),
              ),
              Slider(
                value: _currentSliderValue,
                max: 100,
                divisions: 10,
                activeColor: const Color(0xffB20029),
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              const Padding(padding: EdgeInsets.only(left: 25),
                child:
                SizedBox(
                  height: 22,
                  child: Text("Shape",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Color(0xff272022))),
                ),
              ),
              Slider(
                value: _currentSliderValueShape,
                max: 100,
                divisions: 10,
                activeColor: const Color(0xffB20029),
                label: _currentSliderValueShape.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValueShape = value;
                  });
                },
              ),
              Align(alignment: Alignment.center,child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: const Color(0xffB20029),),

                  onPressed: (){
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                            product: product,
                            userUID: userUID,
                            colorWeight: _currentSliderValue,
                            shapeWeight: _currentSliderValueShape,
                          )),
                    );
              }, child: Text("Submit")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
