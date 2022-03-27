import 'package:comp491/UI/ChangePassword.dart';
import 'package:comp491/modals/dbQueries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userUID}) : super(key: key);
  final String userUID;

  @override
  _ProfileState createState() => _ProfileState(userUID);
}

class _ProfileState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  late String userUID;

  _ProfileState(String _userUID) {
    userUID = _userUID;
  }

  void userChangeName(String text) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: getUsername(userUID),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  // Show error
                }
                if (snapshot.hasData) {
                  // Show data, or you can just close it by Navigator.pop
                  return AlertDialog(
                    title: Text("Profile is updated successfully!"),
                    backgroundColor: Colors.deepOrangeAccent,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white60,
                            )),
                      ),
                    ],
                  );
                } else {
                  // show spinning wheel
                  return const AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    backgroundColor: Colors.deepOrangeAccent,
                    actions: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                  // return CircularProgressIndicator();
                }
              });
        });
    // await user.userChangeName(text).then((value) => () {
    //       //TODO: Not showing dialog.
    //       showDialog(
    //         context: context,
    //         builder: (context) => AlertDialog(
    //           title: Text("Profile is updated successfully!"),
    //           backgroundColor: Colors.deepOrange,
    //           actions: [
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               },
    //               child: Text("OK",
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     color: Colors.white60,
    //                   )),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
  }

  @override
  void initState() {
    super.initState();
    // emailController.text = user.userEmail!;
    // nameController.text = user.getUserName()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 170)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Colors.black54,
                  ),
                  child: FutureBuilder(
                    future: getUsername(userUID),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              snapshot.data,
                              style:
                                  const TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.pencil,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  onPressed: () {},
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //TODO: Cancel the button animations.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 45),
                    primary: Colors.black54,
                  ),
                  child: FutureBuilder(
                    future: getUserEmail(userUID),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshot.hasData) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              snapshot.data,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.pencil,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                  onPressed: () {},
                ),
                const Padding(padding: EdgeInsets.only(top: 8)),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ChangePassword(
                //                 user: user,
                //               )),
                //     );
                //   },
                //   child: Text('Change Password',
                //       textAlign: TextAlign.right,
                //       style: TextStyle(
                //           fontWeight: FontWeight.normal,
                //           fontSize: 13,
                //           color: Colors.white)),
                // ),
              ],
            ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       TextField(
      //         controller: emailController,
      //         enabled: false,
      //         decoration: InputDecoration(
      //           labelText: "Email",
      //         ),
      //       ),
      //       TextField(
      //         controller: roleController,
      //         enabled: false,
      //         decoration: InputDecoration(
      //           labelText: "Role",
      //         ),
      //       ),
      //       TextField(
      //         controller: nameController,
      //         enabled: true,
      //         decoration: InputDecoration(
      //           labelText: "Name",
      //         ),
      //       ),
      //       ElevatedButton(
      //           onPressed: () {
      //             userChangeName(nameController.text);
      //           },
      //           child: Text("Update Profile")
      //       ),
      // ElevatedButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     child: Text("Go back")
      // ),
    );
  }
}
