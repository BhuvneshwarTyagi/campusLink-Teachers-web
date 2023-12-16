import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopThree extends StatelessWidget {
  const TopThree({super.key, required this.data});
  final List<Map<String , dynamic>> data;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(

      height: size.height*0.55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: size.width * 0.1333,
            height: size.height*0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(

                height: size.height*0.28,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    left: size.height*0.035,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Students").doc(data[1]["Email"]).snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ?
                          CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: size.width * 0.044,
                              child: snapshot.data!.data()?['Profile_URL'] != null && snapshot.data!.data()?['Profile_URL'] != "null"
                                  ?
                              CircleAvatar(
                                backgroundColor: Colors.green[600],
                                radius: size.width * 0.04,
                                backgroundImage: NetworkImage(
                                  snapshot.data!.data()?['Profile_URL'],
                                ),
                              )
                                  :
                              CircleAvatar(
                                backgroundColor: Colors.green[600],
                                radius: size.width * 0.04,
                                backgroundImage: const AssetImage("assets/images/unknown.png"),
                              )

                          )
                              :
                          const SizedBox();
                        }
                    ),
                  ),
                  Positioned(

                    left: size.width*0.037,
                    bottom: size.width*0.086,
                    child: Transform.rotate(


                        angle: -0.15,
                        child: SizedBox(
                            height: size.height*0.05,
                            child: Image.asset("assets/images/Silvercrown.png"))),
                  ),
                ],
                ),
              ),
              SizedBox(
                height: size.height*0.01,
              ),
                AutoSizeText(
                  data[1]["Name"]
                  ,
                  style: GoogleFonts.tiltNeon(
                      fontSize: size.width*0.015,
                      color: Colors.black
                  ),

                  textAlign: TextAlign.center,
                ),
                AutoSizeText(
                  "${(data[1]["Submitted"]*100).toStringAsFixed(2)} %",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 52, 84),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                )
            ],
            ),
          ),

          SizedBox(

            width: size.width * 0.1333,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(

                  height: size.height*0.24,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,

                        left: 20,
                        child:     StreamBuilder(
                            stream: FirebaseFirestore.instance.collection("Students").doc(data[0]["Email"]).snapshots(),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ?
                              CircleAvatar(
                                  radius: size.width * 0.044,
                                  backgroundColor: Colors.black,
                                  child:  snapshot.data!.data()?['Profile_URL'] != null && snapshot.data!.data()?['Profile_URL'] != "null"
                                      ?
                                  CircleAvatar(
                                    backgroundColor: Colors.green[600],
                                    radius: size.width * 0.04,
                                    backgroundImage: NetworkImage(snapshot.data!.data()?['Profile_URL'])

                                    ,
                                  )
                                      :
                                  CircleAvatar(
                                    backgroundColor: Colors.green[600],
                                    radius: size.width * 0.04,
                                    backgroundImage: const AssetImage("assets/images/unknown.png"),
                                  )
                              )
                                  :
                              const SizedBox();
                            }
                        ),
                      ),
                      Positioned(
                      top: size.width*0.0047,
                        left: size.width*0.038,
                        child: SizedBox(
                            height: size.height*0.05,
                            child: Image.asset("assets/images/Goldcrown.png")),
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  data[0]["Name"],
                  style: GoogleFonts.tiltNeon(
                    color: Colors.black,
                    fontSize: size.width * 0.015,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                AutoSizeText( "${(data[0]["Submitted"]*100).toStringAsFixed(2)} %",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 52, 84),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(


            width: size.width * 0.1333,
            height: size.height*0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(

                  height: size.height*0.28,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: size.height*0.026,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Students").doc(data[2]["Email"]).snapshots(),
                          builder: (context, snapshot) {
                            return
                              snapshot.hasData
                                  ?
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: size.width * 0.044,
                                child:  snapshot.data!.data()?['Profile_URL'] != null && snapshot.data!.data()?['Profile_URL'] != "null"
                                    ?
                                CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.green[600],
                                    backgroundImage: NetworkImage(snapshot.data!.data()?['Profile_URL'])
                                )
                                    :
                                CircleAvatar(
                                    radius: size.width * 0.04,
                                    backgroundColor: Colors.green[600],
                                    backgroundImage: const AssetImage("assets/images/unknown.png")

                                )
                            )
                                  :
                              const SizedBox();
                          }
                        ),
                      ),

                      Positioned(
                        left: size.width*0.037,
                        bottom: size.width*0.085,
                        child: Transform.rotate(
                          
                            angle: -0.2,
                            child: SizedBox(
                                height: size.height*0.05,
                                child: Image.asset("assets/images/Browncrown.png"))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                AutoSizeText(
                  data[2]["Name"]
                  ,
                  style: GoogleFonts.tiltNeon(
                    color: Colors.black,
                    fontSize: size.width * 0.015,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                AutoSizeText(
                  "${(data[2]["Submitted"]*100).toStringAsFixed(2)} %",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 52, 84),
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
