import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:campus_link_teachers/Screens/Assignment/individual_assignment_leaderboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../../Constraints.dart';
import '../Chat_tiles/Image_viewer.dart';
import '../Chat_tiles/PdfViewer.dart';
import '../Notes/download_tile.dart';
import '../upload_assignmentQuestion.dart';
import 'Assignments.dart';
import 'Submit_button.dart';

class AssignmentTile extends StatefulWidget {
  const AssignmentTile({super.key, });
  @override
  State<AssignmentTile> createState() => _AssignmentTileState();
}

class _AssignmentTileState extends State<AssignmentTile> {
  bool isExpanded = false;

  bool docExists = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    docexits();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: Colors.black, width: 1)
        ),
        width: size.width * 0.12,
        height: size.height * 0.07,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: size.width*0.005,),
              Image.asset("assets/images/upload-icon.png",height: size.height*0.04,width: size.width*0.02,),
              // const Icon(
              //   Icons.upload,
              //   color: Colors.white70,
              // ),
              SizedBox(width: size.width*0.005,),
              AutoSizeText("Upload File",style: GoogleFonts.tiltNeon(
                  color: Colors.black,
                  //const Color.fromRGBO(150, 150, 150, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: size.width*0.01),
              ),
            ],
          ),
          onPressed: () {
            subject_filter.isEmpty
                ?
            showDialog(
              context: context,
              builder: (ctx) =>
                  AlertDialog(

                    title: const Text("Do You Want to Upload Assignment"),
                    content: const Text("Please Apply Filter First"),
                    actions: <Widget>[
                      TextButton(

                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("okay"),
                      ),
                    ],
                  ),
            )
                :
            showDialog(
              context: context,
              builder: (ctx) =>
              const AssigmentQuestion(),
            );
            // Navigator.push(context, PageTransition(
            //   child: const AssigmentQuestion(),
            //   type: PageTransitionType.bottomToTopJoined,
            //   duration: const Duration(milliseconds: 300),
            //   childCurrent: const AssignmentsUpload(),
            //
            // ));
          },
        ),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          child: subject_filter.isEmpty ?
          const Center(
            child: Text("Please Apply filter to see the Assignment"),
          )
              :
          docExists
              ?
          StreamBuilder(

              stream: FirebaseFirestore
                  .instance
                  .collection("Assignment")
                  .doc(
                  "${university_filter.split(" ")[0]} ${college_filter.split(" ")[0]} ${course_filter.split(" ")[0]} ${branch_filter.split(" ")[0]} $year_filter $section_filter $subject_filter")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                return snapshot.hasData
                    ?
                    snapshot.data!.exists
                        ?

                    ListView.builder(
                        scrollDirection: Axis.vertical,

                        shrinkWrap: true,
                      itemCount: snapshot.data!["Total_Assignment"],
                      itemBuilder: (context, index) {
                        String sysPath= "/storage/emulated/0";
                        String path="/Campus Link/$university_filter $college_filter $course_filter $branch_filter $year_filter $section_filter $subject_filter/Assignments/";
                        String newpath =
                            "$sysPath$path/Assignment-${index + 1}.${snapshot
                            .data!["Assignment-${index + 1}"]["Document-type"]}";


                        return InkWell(
                          onTap: (){
                            print("presseddddddddddddd");
                            if( File(newpath).existsSync()) {
                              if (snapshot.data!["Assignment-${index + 1}"]["Document-type"] == "pdf") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          PdfViewer(
                                            document:
                                            newpath,
                                            name:
                                            "Assignment-${index + 1}",
                                          ),
                                    ));
                              }
                              else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                          Image_viewer(path: File(
                                              '${path}Assignment-${index +
                                                  1}.${snapshot
                                                  .data!["Assignment-${index +
                                                  1}"]["Document-type"]}'),

                                          ),
                                    ));
                              }
                            }
                          },
                          child: Card(

                            borderOnForeground: true,
                            shape: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.5,
                                )
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: size.height*0.066,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: size.height*0.01,
                                          ),
                                          AutoSizeText(
                                            subject_filter,
                                            style: GoogleFonts.tiltNeon(
                                                color: Colors.black,
                                                fontSize: size.height*0.015,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          AutoSizeText(
                                            "Assignment: ${index + 1}",
                                            style: GoogleFonts.tiltNeon(
                                                color: Colors.black,
                                                fontSize: size.height*0.015,
                                                fontWeight: FontWeight.w400
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height*0.01,),
                                    ExpansionTile(

                                      iconColor: Colors.black,
                                      backgroundColor: const Color.fromRGBO(60, 99, 100, 1),
                                      collapsedBackgroundColor: const Color.fromRGBO(60, 99, 100, 1),
                                      onExpansionChanged: (value) {
                                        setState(() {
                                          isExpanded=!isExpanded;
                                        });
                                      },

                                      title: AutoSizeText(
                                        "Assignment: ${index + 1} (${(int.parse(snapshot.data!["Assignment-${index + 1}"]["Size"].toString())/1048576).toStringAsFixed(2)}MB)",
                                        style: GoogleFonts.tiltNeon(
                                            color: Colors.black,
                                            fontSize: size.height*0.01,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          AutoSizeText(
                                            "Deadline: ${snapshot
                                                .data!["Assignment-${index +
                                                1}"]["Last Date"]}",
                                            style: GoogleFonts.tiltNeon(
                                                color: Colors.black87,
                                                fontSize: size.width*0.01,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          AutoSizeText(
                                            "Assign: ${(snapshot
                                                .data!["Assignment-${index +
                                                1}"]["Assign-Date"].toDate()).toString().split(" ")[0]}",
                                            style: GoogleFonts.tiltNeon(
                                                color: Colors.black87,
                                                fontSize: size.width*0.01,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        const Divider(
                                          color: Colors.black26,
                                          height: 1.5,
                                          endIndent: 4,
                                          indent: 5,
                                          thickness: 1.5,
                                        ),

                                        SubmitButton(index: index,snapshot: snapshot,count: snapshot.data!.data()?["Assignment-${index+1}"]["Submitted-by"]),
                                        const Divider(
                                          color: Colors.black26,
                                          height: 1.5,
                                          endIndent: 4,
                                          indent: 5,
                                          thickness: 1.5,
                                        ),
                                        ListTile(
                                          title: AutoSizeText(
                                            "Leaderboard",
                                            style: GoogleFonts.tiltNeon(
                                                color: Colors.black,
                                                fontSize: size.width*0.01,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          leading: SizedBox(
                                            width: size.width*0.023,
                                            child: Image.asset("assets/images/leaderboard.png"),
                                          ),
                                          onTap: (){
                                            Navigator.push(context, PageTransition(
                                                child: IndividualAssignmentLeaderboard(index: index),
                                                type: PageTransitionType.bottomToTopJoined,
                                                childCurrent: AssignmentsUpload()
                                            ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                Positioned(
                                  top: 8,
                                  right: size.width*0.01,
                                  child: DownloadButton(
                                      downloadUrl: snapshot.data!.data()?["Assignment-${index + 1}"]["Assignment"],
                                      pdfName: "Assignment-${index + 1}.${snapshot.data?.data()?["Assignment-${index + 1}"]["Document-type"]}",
                                      path: path
                                  ),
                                )


                              ],
                            ),
                          ),
                        );
                      },)
                    :
                        const SizedBox()
                    :
                const SizedBox();
              }
          )
              :
          SizedBox(
            child: Center(
              child: AutoSizeText(
                "No Data Found Yet",
                style: GoogleFonts.openSans(
                    color: Colors.white70,
                    fontSize: size.height*0.04
                ),
              ),
            ),
          )


      ),
    );
  }
  Future<void> docexits() async {
    FirebaseFirestore.instance
        .collection("Assignment").doc(
        "${university_filter.split(" ")[0]} ${college_filter.split(
            " ")[0]} ${course_filter.split(" ")[0]} ${branch_filter.split(
            " ")[0]} $year_filter $section_filter $subject_filter")
        .get().then( (value) {
      if(value.exists){

        print(".......Yes Not Null");
        setState(() {


          docExists=true;
        }
        );

      }
      else{
        setState(() {
          docExists=false;
        });
      }

    });
  }
}
