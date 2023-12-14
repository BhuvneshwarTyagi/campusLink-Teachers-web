
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_link_teachers/Database/database.dart';
import 'package:campus_link_teachers/Screens/loadingscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';

import '../Constraints.dart';

class AssigmentQuestion extends StatefulWidget {
  const AssigmentQuestion({super.key});

  @override
  State<AssigmentQuestion> createState() => _AssigmentQuestionState();
}

class _AssigmentQuestionState extends State<AssigmentQuestion> {
  TextEditingController videoController = TextEditingController();

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  late final FilePickerResult? filePath;
  bool fileSelected = false;
  int assignmentCount = 0;

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        height: size.height*0.8,
        width: size.width*0.6,
        decoration: BoxDecoration(
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
        child:Card(
          elevation:30,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.width * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  AutoSizeText(
                    "Upload File",
                    style: GoogleFonts.openSans(
                      fontSize:size.width*0.02,
                      color:Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  const Icon(
                    Icons.cloud_upload,
                    color: Colors.black,
                  )
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Container(

                    height: size.height * 0.06,
                    width: size.width*0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(size.width * 0.033)),
                    ),
                    child: DottedBorder(
                        color: Colors.black,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              size: size.height * 0.04,
                              Icons.upload_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.01,
                            ),
                            AutoSizeText(
                              "Drop item here  or",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.01,

                                    color: Colors.black)
                            ),
                            TextButton(
                              onPressed: () async {
                                await FilePicker.platform
                                    .pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                    allowMultiple: false)
                                    .then((value) {
                                  if (value!.files[0].path!.isNotEmpty) {
                                    filePath = value;
                                    print(
                                        ".......PickedFile${filePath?.files[0].path}");
                                    setState(() {
                                      fileSelected = true;
                                    });
                                  }
                                });
                              },
                              child: AutoSizeText(
                                "Browse File",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            fileSelected
                                ? Icon(
                              size: size.height * 0.02,
                              Icons.check_circle,
                              color: Colors.green.shade800,
                            )
                                : const SizedBox()
                          ],
                        ))),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  height: size.height * 0.06,
                  width: size.width*0.3,
                  child: DottedBorder(
                    color: Colors.black,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    child: TextField(
                      controller: dateInput,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        icon: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.calendar_today, color: Colors.black),
                        ),
                        border: InputBorder.none,
                        hintText: "Enter Date ",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        } else {}
                      },
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  height: size.height * 0.06,
                  width: size.width*0.3,
                  child: DottedBorder(
                    color: Colors.black,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    child: TextField(
                      controller: timeInput,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        icon: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.timer, color: Colors.black),
                        ),
                        border: InputBorder.none,
                        hintText: "Select Time ",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        _selectTime(context);
                      },
                      readOnly: true,
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Container(
                  height: size.height * 0.06,
                  width: size.width * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    onPressed: () async {
                      if (fileSelected &&
                          dateInput.text.toString().isNotEmpty &&
                          timeInput.text.toString().isNotEmpty)

                      {
                        Navigator.push(context, PageTransition(
                            type: PageTransitionType.bottomToTop,
                            duration: const Duration(milliseconds: 400),
                            childCurrent: const AssigmentQuestion(),
                            child: const loading(text: "Data is uploading to server please wait.......")));
                        Reference ref = FirebaseStorage.instance
                            .ref("Assignments")
                            .child(
                            "$university_filter $college_filter $branch_filter $year_filter $section_filter $subject_filter");
                        DateTime stamp = DateTime.now();
                        Reference filename = ref.child("$stamp");
                        TaskSnapshot snap = await filename.putFile(File("${filePath!.files[0].path}"));
                        String pdfURL = await snap.ref.getDownloadURL();
                        Directory? directory = await getApplicationSupportDirectory();
                        String additionalPath = "Assignment";
                        directory = Directory("${directory.path}$additionalPath");
                        File file = await File("${directory.path}/$stamp.pdf").create(recursive: true);
                        await File("${filePath?.files[0].path}").copy(file.path).then((value) {


                          print("..........................After copy result will be$value");
                        }).whenComplete(() {
                          FirebaseFirestore.instance
                              .collection("Assignment")
                              .doc(
                              "${university_filter.split(" ")[0]} ${college_filter.split(" ")[0]} ${course_filter.split(" ")[0]} ${branch_filter.split(" ")[0]} $year_filter $section_filter $subject_filter")
                              .get()
                              .then((value) async {

                            print("...............///.${university_filter.split(" ")[0]} ${college_filter.split(" ")[0]} ${branch_filter.split(" ")[0]} $year_filter $section_filter $subject_filter");

                            if (value.data() == null) {
                              assignmentCount = 0;
                              FirebaseFirestore.instance
                                  .collection("Assignment")
                                  .doc(
                                  "${university_filter.split(" ")[0]} ${college_filter.split(" ")[0]} ${course_filter.split(" ")[0]} ${branch_filter.split(" ")[0]} $year_filter $section_filter $subject_filter")
                                  .set({
                                "Total_Assignment": assignmentCount+1,
                                "Total_Submitted_Assignment":{

                                },

                                "Assignment-${assignmentCount+1}": {
                                  "Assignment": pdfURL,
                                  "Document-type":filePath?.files[0].extension,
                                  "Size":filePath?.files[0].size,
                                  "Assign-Date":stamp,
                                  "Last Date": dateInput.text.toString(),
                                  "Time": selectedTime.toString(),


                                }

                              }).whenComplete(
                                      () => print("........\n\n\n Created"));
                            } else {
                              assignmentCount =
                              value.data()?["Total_Assignment"];

                              FirebaseFirestore.instance
                                  .collection("Assignment")
                                  .doc(
                                  "${university_filter.split(" ")[0]} ${college_filter.split(" ")[0]} ${course_filter.split(" ")[0]} ${branch_filter.split(" ")[0]} $year_filter $section_filter $subject_filter")
                                  .update({
                                "Assignment-${assignmentCount+1}": {
                                  "Assignment": pdfURL,
                                  "Document-type":filePath?.files[0].extension,
                                  "Size":filePath?.files[0].size,
                                  "Assign-Date":stamp,
                                  "Last Date": dateInput.text.toString(),
                                  "Time": selectedTime.toString(),
                                },
                                "Total_Assignment": FieldValue.increment(1)
                              }
                              );
                            }
                            var studentsDoc =     await FirebaseFirestore.instance.collection("Students")
                                .where("University",isEqualTo: university_filter)
                                .where("College",isEqualTo: college_filter)
                                .where("Branch",isEqualTo: branch_filter)
                                .where("Course",isEqualTo: course_filter)
                                .where("Year",isEqualTo: year_filter)
                                .where("Section",isEqualTo: section_filter)
                                .where("Subject",arrayContains: subject_filter).get();
                            List<String> tokens =[];
                            List<String> emails=[];
                            for(int i=0;i<studentsDoc.docs.length ; i++){
                              tokens.add(studentsDoc.docs[i].data()["Token"]);
                              emails.add(studentsDoc.docs[i].data()["Email"]);
                            }
                            for(int i=0;i<tokens.length;i++ ){
                              database().sendPushMessage(tokens[i], "Assignment ${assignmentCount+1} DeadLine: ${dateInput.value.text}","New $subject_filter Assignment", false, "", stamp);
                              await FirebaseFirestore.instance.collection("Students").doc(emails[i]).update({
                                "Notifications" : FieldValue.arrayUnion([{
                                  "title" : "$subject_filter assignment pending.",
                                  'body' : 'Your $subject_filter assignment ${assignmentCount+1} is pending. Please complete your assignment as soon as possible.\nDeadline: ${dateInput.value.text}'
                                }])
                              });
                            }
                          }).whenComplete(
                                () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                        });
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
                            description: "Please fill all the details",
                            leading: const Icon(
                              Icons.error_outline_outlined,
                              color: Colors.red,
                              size: 20,
                            ));
                      }
                    },


                    child: AutoSizeText(
                      "Submit",
                      style: GoogleFonts.openSans(
                          fontSize: size.height * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.inputOnly,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        String timer =
            "${timeOfDay.hour} : ${timeOfDay.minute} ${timeOfDay.period.toString().split(".")[1]}";
        timeInput = TextEditingController(text: timer);
      });
    }
  }
}
