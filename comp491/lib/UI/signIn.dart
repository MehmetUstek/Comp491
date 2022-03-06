import 'package:comp491/modals/authentication_service.dart';
import 'package:email_validator/email_validator.dart';
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

  // void _emailValid() {
  //   setState(() {
  //
  //   });
  // }
  // void _passwordValid() {
  //   setState(() {
  //
  //   });
  // }

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
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  onEditingComplete: () {
                    isEmailValid =
                        EmailValidator.validate(emailController.text.trim());
                    if (isEmailValid) {
                      print("Valid");
                    } else {
                      print("Not Valid");
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: "Email",
                    fillColor: Color(0xffDB7C23),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextField(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    hintStyle: TextStyle(color: Colors.white70),
                    hintText: "Password",
                    fillColor: Color(0xffDB7C23),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(
                      side: BorderSide(
                          width: 0.0,
                          color: Colors.white,
                          style: BorderStyle.solid),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width / 3, 40),
                    primary: Color(0xffDB7C23),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: () {
                    var v = context.read<AuthenticationService>().signIn(
                        emailController.text.trim(),
                        passwordController.text.trim());
                    print(v);
                  },
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 2, 40),
                      side: BorderSide(style: BorderStyle.none)),
                  onPressed: () {
                    // final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                    // provider.login();
                    Future<String?> v = context
                        .read<AuthenticationService>()
                        .signInWithGoogle();
                    v.then((value) => print(value));
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: Text('Sign In With Google',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.white)),
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
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 2 / 3, 20),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 2 / 3, 20)),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 2 / 3, 20),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 2 / 3, 20)),
                    child: Text(
                      "Forgot your password? Reset Password",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
