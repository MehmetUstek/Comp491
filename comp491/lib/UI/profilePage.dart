import 'package:comp491/UI/ChangePassword.dart';
import 'package:comp491/view/dbQueries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userUID}) : super(key: key);
  final String userUID;

  @override
  _ProfileState createState() => _ProfileState(userUID);
}

class _ProfileState extends State<ProfilePage> {
  late String userUID;
  bool isEnabled = false;
  bool isEnabledPass = false;
  late Future usernameFuture;
  late Future futureEmail;

  _ProfileState(String _userUID) {
    userUID = _userUID;
  }

  void userChangeName(String text) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder(
              future: changeUsername(userUID, text),
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
  }

  @override
  void initState() {
    super.initState();
    usernameFuture = getUsername(userUID);
    futureEmail = getUserEmail(userUID);


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
            margin: const EdgeInsets.only(left: 50.0, right: 50.0),
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
                    future: usernameFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshot.hasData) {
                        TextEditingController _controller =
                        TextEditingController(text: snapshot.data);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width:100,
                              child:
                              TextField(
                                controller: _controller,
                                enabled: isEnabled,
                                style:
                                    const TextStyle(fontSize: 12, color: Colors.white),
                                onEditingComplete: (){
                                  userChangeName(_controller.text);
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isEnabled = true;
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.pencil,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return const FittedBox(fit: BoxFit.scaleDown,
                          child:CircularProgressIndicator(
                            color: Color(0xffB20029),
                          ),
                        );
                      }
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      isEnabled = true;
                    });

                  },
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
                    future: futureEmail,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasError) {
                        // Show error
                        return const Text(
                            "Error Occurred while downloading user data");
                      }
                      if (snapshot.hasData) {
                        TextEditingController _controller =
                        TextEditingController(text: snapshot.data);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width:200,
                              child:
                              TextField(
                                controller: _controller,
                                enabled: isEnabled,
                                style:
                                const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isEnabledPass = true;
                                });
                              },
                              icon: const Icon(
                                CupertinoIcons.pencil,
                                color: Colors.white,
                              ),
                              color: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        return const FittedBox(fit: BoxFit.scaleDown,
                          child:CircularProgressIndicator(
                            color: Color(0xffB20029),

                          ),
                        );
                      }
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      isEnabledPass = true;
                    });
                  },
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
