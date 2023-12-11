import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_link_teachers/Registration/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Constraints.dart';
import '../Screens/Main_page.dart';
import 'forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool hide = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String errorString = "";



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,



          child:Padding(
              padding: EdgeInsets.fromLTRB(size.width * 0.3,
                  size.height*0.02, size.width * 0.3, size.height*0.02),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.5),
                    spreadRadius: 0.5,
                    blurRadius: 4,
                    offset: Offset(0, -4), // changes position of shadow
                  ),
                ],
              ),
              child: Card(


                elevation:30,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height:size.height*0.05,
                    ),

                    Container(
                      height:size.height*0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Regcon,
                              border: Border.all(color: Colors.black),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 60,
                                    blurStyle: BlurStyle.outer,
                                    color: Colors.black54,
                                    offset: Offset(1, 1))
                              ],
                              image: const DecorationImage(
                                  image: AssetImage("assets/icon/icon.png")),
                            ),
                            height: size.height*0.1,
                            width: size.height*0.1,
                          ),
                          SizedBox(
                            width:size.width*0.01,
                          ),
                          AutoSizeText(
                              'CampusLink',style: GoogleFonts.lora(
                            fontSize:size.width*0.02,
                            fontWeight:FontWeight.w900,
                            color:Colors.black,
                          )
                          )
                        ],
                      ),
                    ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                    Row(
                        children: [
                      SizedBox(
                        width:size.width*0.05,
                      ),
                      AutoSizeText("Email Address",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                              fontWeight: FontWeight.w900,
                              color: Colors.black)
                      )
                    ]),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                Container(
                  width: size.width*0.3,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 20,
                          color: Colors.black,
                          offset: Offset(1, 1))
                    ],
                  ),
                  child: TextFormField(
                      controller: _email,
                      obscureText: false,
                      enableSuggestions: true,
                      autocorrect: true,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _email.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear_outlined,
                              color: Colors.black,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.mail_outline_outlined,
                            color: Colors.black,
                          ),
                          label: const Text("Email address",style: TextStyle(fontWeight: FontWeight.bold)),
                          labelStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white.withOpacity(0.9),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none))),
                      keyboardType: TextInputType.emailAddress),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                    Row(children: [
                      SizedBox(
                        width:size.width*0.05,
                      ),
                      AutoSizeText("Password",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.01,
                              fontWeight: FontWeight.w900,
                              color: Colors.black))
                    ]),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                Container(
                  width: size.width*0.3,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 20,

                          color: Colors.black,
                          offset: Offset(1, 1))
                    ],
                  ),
                  child: TextFormField(
                      controller: _password,
                      obscureText: hide,
                      enableSuggestions: false,
                      autocorrect: false,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          suffixIcon: hide
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hide = !hide;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                  ),
                          )
                              : IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hide = !hide;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.black,
                                  )),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.black,
                          ),
                          label: const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
                          labelStyle:
                              TextStyle(color: Colors.black26.withOpacity(0.7)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.white.withOpacity(0.9),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none))),
                      keyboardType: TextInputType.visiblePassword),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Row(
                      children: [
                        SizedBox(
                          width:size.width*0.135,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: const ForgotPassword(),
                                    type: PageTransitionType.rightToLeftJoined,
                                    childCurrent: const SignInScreen(),
                                    duration: const Duration(milliseconds: 350)));
                          },
                          child:  Text("Forgot your password ?",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: MediaQuery.of(context).size.width * 0.01,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 30,
                                        offset: Offset(3, 3),
                                        color: Colors.black54)
                                  ])),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Material(
                    shadowColor: Colors.blue,
                    elevation: 10,
                    shape:OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    child: ListTile(
                      dense:true,
                      contentPadding: EdgeInsets.symmetric(vertical:0),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      tileColor: Colors.black,
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection("Teacher_record")
                            .doc("Email")
                            .get()
                            .then((value) async {
                          List temp = value.data()!["Email"];
                          if (temp.contains(_email.text.trim())) {
                            await signin(_email.text.trim(), _password.text.trim())
                                .then((value) {
                              if (value == "1") {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    child: const MainPage(),
                                    type: PageTransitionType.rightToLeftJoined,
                                    duration: const Duration(milliseconds: 400),
                                    alignment: Alignment.bottomCenter,
                                    childCurrent: const SignInScreen(),
                                  ),
                                );
                              } else {
                                InAppNotifications.instance
                                  ..titleFontSize = 14.0
                                  ..descriptionFontSize = 14.0
                                  ..textColor = Colors.black
                                  ..backgroundColor =
                                      const Color.fromRGBO(150, 150, 150, 1)
                                  ..shadow = true
                                  ..animationStyle =
                                      InAppNotificationsAnimationStyle.scale;
                                InAppNotifications.show(
                                    title: 'Failed',
                                    duration: const Duration(seconds: 2),
                                    description: value,
                                    leading: const Icon(
                                      Icons.error_outline_outlined,
                                      color: Colors.red,
                                      size: 55,
                                    ));
                              }
                            });
                          } else {
                            InAppNotifications.instance
                              ..titleFontSize = 14.0
                              ..descriptionFontSize = 14.0
                              ..textColor = Colors.black
                              ..backgroundColor =
                                  const Color.fromRGBO(150, 150, 150, 1)
                              ..shadow = true
                              ..animationStyle =
                                  InAppNotificationsAnimationStyle.scale;
                            InAppNotifications.show(
                                title: 'Failed',
                                duration: const Duration(seconds: 2),
                                description: "No such account found",
                                leading: const Image(
                                    image: AssetImage('assets/icon/icon.png')));
                          }
                        });
                      },

                      title: AutoSizeText(
                        "LOG IN",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: size.width * 0.012,),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),

                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                signUpOption(),
          ],
          ),
              ),
            ),
      ),
        ));
  }

  Column signUpOption() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            "Don't have an account?",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.011,
            ),
          ),
        ],
      ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black54, width: 2),
              ),
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(vertical:0),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      child: const SignUpScreen(),
                      type: PageTransitionType.rightToLeftJoined,
                      duration: const Duration(milliseconds: 350),
                      childCurrent: const SignInScreen(),
                    ),
                  );
                },
                title: AutoSizeText(
                  "SIGN UP",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.008,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            blurRadius: 30,
                            offset: Offset(3, 3),
                            color: Colors.black54)
                      ]),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<String> signin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "1";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.toString().split(']')[1].trim();
    }
  }
}
