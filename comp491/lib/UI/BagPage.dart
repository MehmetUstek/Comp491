import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp491/view/Product.dart';
import 'package:comp491/view/dbQueries.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class ImprovementPage extends StatefulWidget {
  final String? userUID;

  const ImprovementPage({Key? key, required this.userUID}) : super(key: key);

  @override
  _ImprovementPage createState() => _ImprovementPage();
}

class _ImprovementPage extends State<ImprovementPage> {
  var future;
  late int totalAmount = 0;
  late String? userUID;
  final ref = FirebaseStorage.instance.ref();

  // FutureBuilder(
  // future: getAllProducts(),
  // builder: (BuildContext context,
  //     AsyncSnapshot<dynamic> snapshot) {
  // if (snapshot.hasError) {
  // // Show error
  // return const Text(
  // "Error Occurred while downloading user data");
  // }
  // if (snapshot.hasData) {
  // return Image.asset(
  // "../data_crawling/images/image"+ shoppingBag[index].imageId+"sub1.png",
  // fit: BoxFit.fitHeight,
  // );
  // } else {
  // return const CircularProgressIndicator();
  // }
  // },
  // ),

  @override
  void initState() {
    super.initState();
    userUID = widget.userUID;
    future = getUserBagByUserUID(userUID!);
  }

  double headerSize = 17;
  double slideItemWidth = 75;

  void deleteProduct(BuildContext context, Pid) {
    // Add listener if needed.
    // Slidable.of(context)!.dismissGesture.addListener(() { print('dismissed'); });
    deleteProductFromUserBagByUserUIDandPid(userUID, Pid);
    Slidable.of(context)!.dismiss(
      ResizeRequest(const Duration(milliseconds: 20), () {}),
      duration: const Duration(milliseconds: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("Product Finder",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ))),

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
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 20)),
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
              const Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                //TODO: Change later.
                height: MediaQuery.of(context).size.height * 4 / 7-15,
                child: FutureBuilder(
                    future: future,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot2) {
                      if (snapshot2.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user bag data");
                      }
                      if (snapshot2.hasData) {
                        List<Product> product_list = snapshot2.data;
                        totalAmount = 0;

                        for(Product product in product_list){
                          totalAmount += int.parse(product.price);
                        }
                        return ListView.builder(
                            //TODO: Change later.
                            // itemCount: todos.length,
                            itemCount: product_list.length,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            scrollDirection: Axis.vertical,
                            addAutomaticKeepAlives: false,
                            cacheExtent: 100,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              Product product = product_list[index];
                              String title = product.title;
                              String price = product.price;
                              var img1Name = ref.child(
                                  'images/' + product.image1 + '.png');
                              return Slidable(
                                key: const ValueKey(0),

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  // dismissible: DismissiblePane(onDismissed: () {}),
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      //TODO: Write OnPressed.
                                      onPressed: (BuildContext context) {
                                        deleteProduct(context,
                                            product_list[index].productId);
                                      },
                                      autoClose: false,

                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_rounded,
                                      label: 'Delete',
                                    ),
                                    const SlidableAction(
                                      flex: 2,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            side: const BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          elevation: 10,
                                          shadowColor: Colors.black,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                FutureBuilder(
                                                    future: img1Name
                                                        .getDownloadURL(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<dynamic>
                                                            snapshot1) {
                                                      if (snapshot1.hasError) {
                                                        // Show error
                                                        return const Text(
                                                            "Error Occurred while downloading user data");
                                                      }
                                                      if (snapshot1.hasData) {
                                                        return CachedNetworkImage(
                                                            imageUrl: snapshot1
                                                                .data,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Color(
                                                                        0xffB20029),
                                                                  ),
                                                                ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                            fit: BoxFit
                                                                .fitHeight);
                                                      } else {
                                                        return const FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Color(
                                                                0xffB20029),
                                                          ),
                                                        );
                                                      }
                                                    }),
                                                // Image.asset(
                                                //   "../data_crawling/images/image"+ shoppingBag[index].imageId+"sub1.png",
                                                //   fit: BoxFit.fitHeight,
                                                // ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      child: Text(title,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black)),
                                                      width: 150,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Text(price + " \$",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 13,
                                                              color: Colors
                                                                  .black45)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
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
              Center(
                child: Container(
                  height: 2,
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('TOTAL',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Arial",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87)),
                         Text('$totalAmount \$',
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontFamily: "Arial",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
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
                      primary: const Color(0xff272022),
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
