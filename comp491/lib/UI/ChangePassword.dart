import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../modals/User.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key, required this.user}) : super(key: key);
  final UserData user;

  @override
  _ChangePassword createState() => _ChangePassword(user);
}

class _ChangePassword extends State<ChangePassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  late UserData user;

  _ChangePassword(UserData _user) {
    this.user = _user;
  }

  @override
  void initState() {
    super.initState();
    emailController.text = user.userEmail!;
    nameController.text = user.getUserName()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [
              0.5,
              0.9,
            ],
            colors: [
              Color(0xffA9C7F2),
              Color(0xff8DB5EE),
            ],
          )),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 100)),
                Center(
                  child: SizedBox(
                    height: 25,
                    child: Text('Change Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 25)),

                // IconButton(
                //   onPressed: () {},
                //     icon: Icon(
                //       CupertinoIcons.person_alt_circle,
                //       color: Colors.white,
                //
                //     ),
                //   color: Colors.white,
                //   iconSize: 100,
                //
                // ),
                Container(
                  height: 45,
                  child: TextField(
                    // controller: emailController,
                    // onEditingComplete: () {
                    //   isEmailValid =
                    //       EmailValidator.validate(emailController.text.trim());
                    //   if (isEmailValid) {
                    //     print("Valid");
                    //   } else {
                    //     print("Not Valid");
                    //   }
                    // },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 0.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
                      hintText: "Current Password",
                      fillColor: Color(0xffE4EDFB),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                Container(
                  height: 45,
                  child: TextField(
                    // controller: emailController,
                    // onEditingComplete: () {
                    //   isEmailValid =
                    //       EmailValidator.validate(emailController.text.trim());
                    //   if (isEmailValid) {
                    //     print("Valid");
                    //   } else {
                    //     print("Not Valid");
                    //   }
                    // },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                            width: 0.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 12),
                      hintText: "New Password",
                      fillColor: Color(0xffE4EDFB),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 15)),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(
                        side: BorderSide(
                            width: 0.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                      ),
                      fixedSize: Size(
                          MediaQuery.of(context).size.width *
                              MediaQuery.of(context).devicePixelRatio /
                              5,
                          40),
                      primary: Color(0xff64A1F7),
                    ),
                    child: Text(
                      'Update Password',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                // Padding(padding: EdgeInsets.only(top: 7)),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword(
                                  user: user,
                                )),
                      );
                    },
                    child: Text('Forgot your password? Reset',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.white)),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
              ],
            ),
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
