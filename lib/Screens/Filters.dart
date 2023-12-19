import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_link_teachers/Screens/Navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../Constraints.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {

  double _value=8;
  Color headingcolor=Colors.cyan;
  Color optioncolor=Colors.white;

  List<dynamic>? university_list = [];
  List<dynamic>? clg_list = [];
  List<dynamic>? course_list = [];
  List<dynamic>? branch_list = [];
  List<dynamic>? year_list = [];
  List<dynamic>? section_list = [];
  List<dynamic>? subject_list = [];

  final ScrollController _controller = ScrollController();
  var currentuni = "";
  var currentclg = "";
  var currentcourse = "";
  var currentbranch = "";
  var currentyear = "";
  var currentsection = "";
  var currentsubject = "";

  int uni_index=-1;
  int clgIndex = -1;
  int courseIndex = -1;
  int branchIndex = -1;
  int yearIndex = -1;
  int sectionIndex = -1;
  int subjectIndex = -1;
  @override
  Widget build(BuildContext context) {
    Color headingcolor=Colors.black;
    Color optioncolor=Colors.black;
    Color dotcolor=Colors.black;
    Size size = MediaQuery.of(context).size;
    return  Center(
        child: Container(
          height: size.height*0.8,
          width: size.width*0.6,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
              BoxShadow(
                color: Colors.black26.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 4,
                offset: const Offset(0, -4), // changes position of shadow
              ),
            ],
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Card(
              elevation:30,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  AutoSizeText(
                    "Filter",
                    style: GoogleFonts.gfsDidot(fontSize: size.height*0.05, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                    child: AutoSizeText(
                      "Range",
                      style: GoogleFonts.exo(
                          fontSize: size.height*0.03,
                          color: headingcolor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Slider(
                    activeColor: Colors.deepPurple.shade400,
                    inactiveColor: Colors.black26,
                    divisions: 33,
                    autofocus: false,
                    label: "$_value",
                    min: 7,
                    max: 40,
                    value: _value,
                    onChanged: (value){
                      setState(() {
                        _value=value;
                        range=value;
                      });
                      }
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.7,
                    width: size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Teachers")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("Teachings")
                            .doc("Teachings")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData && snapshot.data!.exists){
                            university_list = snapshot.data?.data()?["University"] ?? [];
                          }

                          if (!snapshot.hasData || university_list!.isEmpty) {
                            return snapshot.data!.data()?["Subject"] != null ? Center(
                              child: CircularProgressIndicator(
                                color: dotcolor,
                              ),
                            ) : const Center(
                              child: AutoSizeText("No teaching details found"),
                            );
                          } else {
                            return SizedBox(
                              height: size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "University",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * university_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,

                                            itemCount: university_list?.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(
                                                splashColor: Colors.transparent,

                                                onTap: () => setState(
                                                  () {
                                                    uni_index=index;
                                                    currentuni = university_list?[index];
                                                    clg_list = snapshot.data?.data()?["College-$uni_index"];
                                                    _controller.animateTo(
                                                        _controller.position.maxScrollExtent,
                                                        duration: const Duration(milliseconds: 100),
                                                        curve: Curves.linear,
                                                    );

                                                    course_list = [];
                                                    branch_list = [];
                                                    year_list = [];
                                                    section_list = [];
                                                    subject_list = [];

                                                    currentclg = "";
                                                    currentcourse = "";
                                                    currentbranch = "";
                                                    currentyear = "";
                                                    currentsection = "";
                                                    currentsubject = "";
                                                  },
                                                ),
                                                title: Text(university_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                  color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                  fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: university_list?[index],
                                                  groupValue: currentuni,
                                                  onChanged: (value) {
                                                    setState(
                                                      () {

                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), // University
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Colleges",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    height: size.height * 0.07 * clg_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    duration: const Duration(milliseconds: 300),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: clg_list?.length,

                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () => setState(
                                                  () {
                                                    clgIndex=index;
                                                    currentclg = clg_list?[index];
                                                    course_list = snapshot.data?.data()?["Course-$uni_index$clgIndex"];
                                                    _controller.animateTo(
                                                        _controller
                                                            .position.maxScrollExtent,
                                                        duration: const Duration(
                                                            milliseconds: 100),
                                                        curve: Curves.linear);

                                                    branch_list = [];
                                                    year_list = [];
                                                    section_list = [];
                                                    subject_list = [];
                                                    currentcourse = "";
                                                    currentbranch = "";
                                                    currentyear = "";
                                                    currentsection = "";
                                                    currentsubject = "";
                                                  },
                                                ),
                                                title: Text(clg_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: clg_list?[index],
                                                  groupValue: currentclg,
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ), // College
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Course",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * course_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: course_list?.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      courseIndex = index;
                                                      branch_list = snapshot.data?.data()?["Branch-$uni_index$clgIndex$courseIndex"];
                                                      currentcourse = course_list![index];
                                                      _controller.animateTo(
                                                        _controller.position.maxScrollExtent,
                                                        duration: const Duration(milliseconds: 100),
                                                        curve: Curves.linear,

                                                      );
                                                      year_list = [];
                                                      section_list = [];
                                                      subject_list = [];
                                                      currentbranch = "";
                                                      currentyear = "";
                                                      currentsection = "";
                                                      currentsubject = "";

                                                    },
                                                  );
                                                },
                                                title: Text(course_list?[index]),

                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: course_list?[index],
                                                  groupValue: currentcourse,
                                                  onChanged: (value) {
                                                    setState(
                                                      () {

                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Branch",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * branch_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: branch_list?.length,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    branchIndex = index;
                                                    year_list = snapshot.data!.data()!["Year-$uni_index$clgIndex$courseIndex$branchIndex"];
                                                    currentbranch = branch_list![index];
                                                    _controller.animateTo(
                                                      _controller.position.maxScrollExtent,
                                                      duration: const Duration(milliseconds: 100),
                                                      curve: Curves.linear,
                                                    );
                                                    section_list = [];
                                                    subject_list = [];
                                                    currentyear = "";
                                                    currentsection = "";
                                                    currentsubject = "";
                                                  });
                                                },
                                                title: Text(branch_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                      fontSize: size.height*0.07,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: branch_list?[index],
                                                  groupValue: currentbranch,
                                                  onChanged: (value) {
                                                    setState(
                                                      () {
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Year",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * year_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: year_list?.length,

                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    yearIndex = index;
                                                    section_list = snapshot.data!.data()!["Section-$uni_index$clgIndex$courseIndex$branchIndex$yearIndex"];
                                                    currentyear = year_list![index];
                                                    _controller.animateTo(
                                                      _controller.position.maxScrollExtent,
                                                      duration: const Duration(milliseconds: 100),
                                                      curve: Curves.linear,
                                                    );
                                                    subject_list = [];
                                                    currentsection="";
                                                    currentsubject = "";
                                                  });
                                                },
                                                title: Text(year_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: year_list?[index],
                                                  groupValue: currentyear,
                                                  onChanged: (value) {
                                                    setState(
                                                          () {
                                                            yearIndex = index;
                                                            section_list = snapshot.data!.data()!["Section-$yearIndex"];
                                                            currentyear = value;
                                                            _controller.animateTo(
                                                              _controller.position.maxScrollExtent,
                                                              duration: const Duration(milliseconds: 100),
                                                              curve: Curves.linear,
                                                            );
                                                            currentsection = "";
                                                            currentsubject = "";
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Section",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * section_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: section_list?.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    currentsection = section_list![index];
                                                    sectionIndex = index;
                                                    subject_list = snapshot.data!.data()!["Subject-$uni_index$clgIndex$courseIndex$branchIndex$yearIndex$sectionIndex"];

                                                    _controller.animateTo(
                                                      _controller.position.maxScrollExtent,
                                                      duration: const Duration(milliseconds: 100),
                                                      curve: Curves.linear,
                                                    );
                                                    currentsubject = "";
                                                  });
                                                },
                                                title: Text(section_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: section_list![index],
                                                  groupValue: currentsection,
                                                  onChanged: (value) {
                                                    setState(
                                                          () {},
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width * 0.01),
                                    child: AutoSizeText(
                                      "Subject",
                                      style: GoogleFonts.exo(
                                          fontSize: size.height*0.03,
                                          color: headingcolor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height: size.height * 0.07 * subject_list!.length,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: subject_list?.length,

                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    currentsubject = subject_list![index];
                                                    subjectIndex = index;
                                                    _controller.animateTo(
                                                      _controller.position.maxScrollExtent,
                                                      duration: const Duration(milliseconds: 100),
                                                      curve: Curves.linear,
                                                    );
                                                  });
                                                },
                                                title: Text(subject_list?[index]),
                                                titleTextStyle: GoogleFonts.exo(
                                                    color: optioncolor,
                                                    fontSize: size.height*0.02,
                                                    fontWeight: FontWeight.w400
                                                ),
                                                leading: Radio(
                                                  activeColor: dotcolor,
                                                  value: subject_list?[index],
                                                  groupValue: currentsubject,
                                                  onChanged: (value) {
                                                    setState(
                                                          () {},
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),//Course
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.black, width: 1)
                        ),
                        width: size.width * 0.12,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              elevation: 20,
                              backgroundColor: Colors.black26),
                          onPressed: () async {
                            university_filter=currentuni;
                            college_filter=currentclg;
                            course_filter=currentcourse;
                            branch_filter=currentbranch;
                            year_filter=currentyear;
                            section_filter=currentsection;
                            subject_filter = currentsubject;

                            final docref= await FirebaseFirestore
                                .instance
                                .collection("Students")
                                .where("University", isEqualTo: university_filter)
                                .where("College",isEqualTo: college_filter)
                                .where("Course",isEqualTo: course_filter)
                                .where("Branch",isEqualTo: branch_filter)
                                .where("Year",isEqualTo: year_filter)
                                .where("Section",isEqualTo: section_filter)
                                .where("Subject",isEqualTo: subject_filter)
                                .get();
                            docref.docs.forEach((element) async {

                              await FirebaseFirestore.instance.collection("Students").doc(element.data()['Email']).update({
                                "Attendance":true
                              });
                            });
                            Navigator.pushReplacement(context, PageTransition(
                              child: const Nevi(),
                              type: PageTransitionType.bottomToTopJoined,
                              duration: const Duration(milliseconds: 200),
                              alignment: Alignment.bottomCenter,
                              childCurrent: const Filters(),
                            ),);
                          },
                          child: AutoSizeText(
                            "Apply",
                            style: GoogleFonts.tiltNeon(
                                color: Colors.black,
                                fontSize: size.width*0.01),

                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  }

}
