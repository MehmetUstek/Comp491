import 'package:comp491/modals/authentication_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool showValue = false;

  bool isPasswordCompliant(String password, [int minLength = 6]) {
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>-]'));
    bool hasMinLength = password.length > minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  @override
  void initState() {
    super.initState();
  }

  Gradient background = LinearGradient(
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
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          // margin: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
                child: Text('Product Finder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                        color: Color(0xff272022))),
              ),
              const Padding(padding: EdgeInsets.only(top: 50)),

              // Username textfield.
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 6 / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff272022).withOpacity(0.88),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 25,
                      child: TextField(
                        autocorrect: false,
                        enableSuggestions: false,

                        cursorColor: Colors.white54,
                        textAlign: TextAlign.start,
                        controller: emailController,
                        onEditingComplete: () {
                          isEmailValid = EmailValidator.validate(
                              emailController.text.trim());
                          if (isEmailValid) {
                            print("Valid");
                          } else {
                            print("Not Valid");
                          }
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white,
                          decoration: TextDecoration.none,

                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),

              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 6 / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff272022).withOpacity(0.88),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 25,
                      child: TextField(
                        cursorColor: Colors.white54,
                        obscureText: true,
                        controller: passwordController,
                        onEditingComplete: () {
                          isPasswordValid =
                              isPasswordCompliant(passwordController.text.trim());
                          if (isPasswordValid) {
                            print("Valid pass");
                          } else {
                            print("Not Valid pass");
                          }
                        },
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Row(children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 22.0)),
                Theme(
                    data: ThemeData(
                      // primarySwatch: Colors.,
                      unselectedWidgetColor: Colors.black87, // Your color
                    ),
                    child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Color(0xff272022),

                        // fillColor: MaterialStateProperty.all(Color(0xffFEC7D4)),
                        value: showValue,
                        onChanged: (bool? value) {
                          setState(() {
                            showValue = value!;
                          });
                        })),
                Text('Remember me',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.black)),
              ]),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(
                        width: 0.0,
                        color: Colors.white,
                        style: BorderStyle.solid),
                  ),
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 4 / 5, 45),
                  primary: Color(0xff272022),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                onPressed: () {
                  Future<User?> v = context
                      .read<AuthenticationService>()
                      .signIn(emailController.text.trim(),
                          passwordController.text.trim());
                  print(v);
                  v.then((value) => () {
                        setState(() {});
                      });
                },
              ),

              Padding(padding: EdgeInsets.only(top: 10.0)),
              SizedBox(
                height: 25,
                child: TextButton(
                  onPressed: () {
                    if (isEmailValid && isPasswordValid) {
                      Future<String?> v = context
                          .read<AuthenticationService>()
                          .signUp(emailController.text.trim(),
                              passwordController.text.trim());
                      print("Returned user");
                      print(v);

                      v.then((value) => print(value));
                    } else {
                      //TODO: Will change design.
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Invalid email or password"),
                          backgroundColor: Colors.black26,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white60,
                                  )),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Don't have an account? Sign Up!",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  style: TextButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 2 / 3, 20),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 2 / 3, 20)),
                ),
              ),
              // SizedBox(
              //   height: 25,
              //   child: TextButton(
              //     onPressed: () {},
              //     style: TextButton.styleFrom(
              //         fixedSize:
              //             Size(MediaQuery.of(context).size.width * 2 / 3, 20),
              //         padding: EdgeInsets.zero,
              //         alignment: Alignment.center,
              //         minimumSize:
              //             Size(MediaQuery.of(context).size.width * 2 / 3, 20)),
              //     child: Text(
              //       "Forgot your password? Reset Password",
              //       style: TextStyle(color: Colors.white, fontSize: 12),
              //     ),
              //   ),
              // ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 2,
                    color: Colors.black,
                    width: 130,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text("Or Sign In With",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.black)),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Container(
                    height: 2,
                    color: Colors.black,
                    width: 130,
                  ),
                ],
              ),
              // OutlinedButton.icon(
              //   style: OutlinedButton.styleFrom(
              //       fixedSize: Size(MediaQuery.of(context).size.width / 2, 40),
              //       side: BorderSide(style: BorderStyle.none)),
              //   onPressed: () {
              //     // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
              //     // provider.login();
              //     Future<String?> v =
              //         context.read<AuthenticationService>().signInWithGoogle();
              //     v.then((value) => print(value));
              //   },
              //   icon: FaIcon(
              //     FontAwesomeIcons.google,
              //     color: Colors.red,
              //   ),
              //   label: Text('Sign In With Google',
              //       textAlign: TextAlign.right,
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 13,
              //           color: Colors.white)),
              // ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                  Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(
                              width: 0.0,
                              color: Colors.white,
                              style: BorderStyle.solid),
                        ),
                        fixedSize: Size(60, 60),
                        primary: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Color(0xff272022),
                      ),
                      onPressed: () {
                        Future<String?> v = context
                            .read<AuthenticationService>()
                            .signInWithGoogle();
                        v.then((value) => print(value));
                        setState(() {});
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Google',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(
                              width: 0.0,
                              color: Colors.white,
                              style: BorderStyle.solid),
                        ),
                        fixedSize: Size(60, 60),
                        primary: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.apple,
                        color: Color(0xff272022),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Apple',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          side: BorderSide(
                              width: 0.0,
                              color: Colors.white,
                              style: BorderStyle.solid),
                        ),
                        fixedSize: Size(60, 60),
                        primary: Colors.white,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.microsoft,
                        color: Color(0xff272022),
                      ),
                      onPressed: () {},
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Microsoft',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.black)),
                    )
                  ],
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
