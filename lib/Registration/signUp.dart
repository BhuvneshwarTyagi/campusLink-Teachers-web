import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Constraints.dart';
import 'Login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String errorString="";
  bool hide =true;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: Container(

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color:Colors.grey[800],
          child: Padding(
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
                shadowColor: Colors.white,
                elevation:30,
                color:Colors.white,

                child: Column(

                  children: [
                    SizedBox(
                      height:size.height*0.05,
                    ),
                    Container(

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
                                    offset: Offset(1, 1)
                                  )
                                ],
                              image: const DecorationImage(
                                  image: AssetImage("assets/icon/icon.png")),
                            ),
                            height: size.height*0.1,
                            width: size.height*0.1,
                          ),
                          SizedBox(
                            width:size.width*0.001,
                          ),
                          AutoSizeText(
                              'CampusLink',style: GoogleFonts.lora(
                            fontSize:size.width*0.02,
                            fontWeight:FontWeight.w900,
                            color:Colors.black,
                          )
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.06,
                    ),
                    Column(
                      children: [
                        Row(children: [
                          SizedBox(
                            width:size.width*0.05,
                          ),
                          AutoSizeText(" Enter your Email Address",
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
                          width:size.width*0.3,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.black,),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 20,

                                  color: Colors.black54,
                                  offset: Offset(1, 1)
                              )
                            ],
                          ),
                          child: TextField(
                              controller: email,
                              obscureText: false,
                              enableSuggestions: true,
                              autocorrect: true,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        email.clear();
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
                                  label: const Text("Enter Email"),
                                  labelStyle: TextStyle(
                                      color: Colors.black26.withOpacity(0.7)),
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  fillColor: Colors.white.withOpacity(0.9),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)
                                  )
                              ),
                              keyboardType: TextInputType.emailAddress),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),
                        Row(children: [
                          SizedBox(
                            width:size.width*0.05,
                          ),
                          AutoSizeText("Enter Password",
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
                          width:size.width*0.3,
                          height: size.height*0.06,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.black,),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 20,

                                  color: Colors.black54,
                                  offset: Offset(1, 1)
                              )
                            ],
                          ),
                          child: TextField(
                              controller: password,
                              obscureText: hide,
                              enableSuggestions: false,
                              autocorrect: false,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.white.withOpacity(0.9)),
                              decoration: InputDecoration(
                                  suffixIcon: hide
                                      ?
                                  IconButton(onPressed: (){
                                    setState(() {
                                      hide=!hide;
                                    });
                                  }, icon: const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.white,
                                  ))
                                      :
                                  IconButton(onPressed: (){
                                    setState(() {
                                      hide=!hide;
                                    });
                                  }, icon: const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white,
                                  )),

                                  prefixIcon: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  label: const Text("Enter Password"),
                                  labelStyle: TextStyle(
                                      color: Colors.black26.withOpacity(0.7)),
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  fillColor: Colors.white.withOpacity(0.9),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none)
                                  )
                              ),
                              keyboardType: TextInputType.visiblePassword),
                        ),
                        SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.06
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.3,
                          height: MediaQuery.of(context).size.height*0.06,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black,width: 2)
                          ),
                          child: Material(
                            shadowColor: Colors.blue,
                            elevation:10,
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(vertical:0),
                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                              tileColor: Color.fromARGB(255, 5, 22, 44),
                              onTap: () async{
                                if(email.text.trim().isNotEmpty){
                                  String temp = await signIn(email.text.trim(), password.text.trim());
                                  await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                  final record = await FirebaseFirestore.instance.collection("Teacher_record").doc("Email").get();
                                  record.exists
                                      ?
                                  await FirebaseFirestore.instance.collection("Teacher_record").doc("Email").update({
                                    "Email": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.email])
                                  })
                                      :
                                  await FirebaseFirestore.instance.collection("Teacher_record").doc("Email").set({
                                    "Email": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.email])
                                  })
                                  ;
                                  if(temp=='1'){
                                    InAppNotifications.instance
                                      ..titleFontSize = 14.0
                                      ..descriptionFontSize = 14.0
                                      ..textColor = Colors.black
                                      ..backgroundColor = const Color.fromRGBO(150, 150, 150, 1)
                                      ..shadow = true
                                      ..animationStyle = InAppNotificationsAnimationStyle.scale;
                                    InAppNotifications.show(
                                        title: 'Successfully',
                                        duration: const Duration(seconds: 2),
                                        description: 'Your account is created successfully. Please verify your email',
                                        leading: const Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                          size: 55,
                                        )
                                    );
                                  }


                                  else{
                                    InAppNotifications.instance
                                      ..titleFontSize = 14.0
                                      ..descriptionFontSize = 14.0
                                      ..textColor = Colors.black
                                      ..backgroundColor = const Color.fromRGBO(150, 150, 150, 1)
                                      ..shadow = true
                                      ..animationStyle = InAppNotificationsAnimationStyle.scale;
                                    InAppNotifications.show(
                                        title: 'Failed',
                                        duration: const Duration(seconds: 2),
                                        description: temp,
                                        leading: const Icon(
                                          Icons.error_outline_outlined,
                                          color: Colors.red,
                                          size: 55,
                                        )
                                    );
                                  }
                                }
                                else{
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
                                      description: "Email id can not be empty",
                                      leading: const Icon(
                                        Icons.error_outline_outlined,
                                        color: Colors.red,
                                        size: 55,
                                      ));
                                }

                              },

                              title:  AutoSizeText("Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: size.width * 0.012,
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: size.height * 0.1
                    ),
                    signInOption(),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?", style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,)
          ,),
        TextButton(

          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: const SignInScreen(),
                type: PageTransitionType.leftToRightJoined,
                duration: const Duration(milliseconds: 350),
                childCurrent: const SignUpScreen(),
              ),
            );
          },
          child: const Text("Sign In", style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 30,
                offset: Offset(3, 3),
                color: Colors.black54
              )
            ]
          )

          ),
        )
      ],
    );
  }
  Future<String> signIn(String email, String password) async {
    try {
      await  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return "1";
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return e.toString().split(']')[1].trim();
    }
  }
}
