import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constraints.dart';
import 'chat.dart';

class chatsystem extends StatefulWidget {
  const chatsystem({super.key});

  @override
  State<chatsystem> createState() => _chatsystemState();
}

class _chatsystemState extends State<chatsystem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markFalse();
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.black38,
        //   shadowColor: Colors.transparent,
        //   titleSpacing: 0,
        //   leadingWidth: size.width*0.13,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        //     onPressed: (){
        //       Navigator.pop(context);
        //     },
        //   ),
        //   title: Row(
        //     children: [
        //
        //       SizedBox(
        //         height: size.height*0.045,
        //           width: size.width*0.1,
        //           child: Image.asset("assets/images/chat-icon.png"),
        //       ),
        //       SizedBox(width: size.width*0.02,),
        //       Text("Chats",
        //         style: GoogleFonts.aBeeZee(
        //           color: Colors.black,
        //           fontWeight: FontWeight.w600,
        //
        //         ),
        //       ),
        //     ],
        //   ),
        //   actions: <Widget> [
        //
        //     PopupMenuButton(
        //       icon: Icon(Icons.more_vert,size: size.height*0.04,color: Colors.black,),
        //       itemBuilder: (context) {
        //
        //         return[
        //           PopupMenuItem(
        //               child:TextButton(
        //                   onPressed: (){
        //
        //                   }, child:const Text("Search",style: TextStyle(color: Colors.black),))),
        //           PopupMenuItem(
        //               child: StreamBuilder(
        //                 stream: FirebaseFirestore.instance.collection("Messages").doc(usermodel["Message_channels"][0]).snapshots(),
        //                 builder: (context, snapshot) {
        //                   return snapshot.hasData
        //                       ?
        //                   TextButton(
        //                     onPressed: (){
        //                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Background_image(groupimage: snapshot.data!.data()!["image_URL"], channel: usermodel["Message_channels"][0],),
        //                       ),
        //                       );
        //
        //                     },
        //                     child:const Text("Wallpaper",style: TextStyle(color: Colors.black),
        //                     ),
        //                   )
        //                       :
        //                   CircleAvatar(
        //                     backgroundColor: const Color.fromRGBO(86, 149, 178, 1),
        //                     radius: size.width*0.07,
        //                     child: const CircularProgressIndicator(),
        //                   );
        //                 },
        //               ),
        //           ),
        //
        //         ];
        //       },)
        //   ],
        // ),
        body: usermodel["Message_channels"]==null || usermodel["Message_channels"].length<0
            ?
        Center(
          child: Container(

            height: size.height*0.1,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(
                  colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.1),
              ])
            ),
            child: Center(
              child: AutoSizeText("Please add subject first.",style: GoogleFonts.aBeeZee(
                color: Colors.white,
                fontSize: size.height*0.015,
                fontWeight: FontWeight.w600
              ),)
            ),
          ),
        )
            :
        Container(
          color: Colors.transparent,
          height: size.height*0.9,

          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            reverse: true,
            itemCount: usermodel["Message_channels"].length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: size.height*0.1,

                child: StreamBuilder(

                    stream: FirebaseFirestore.instance.collection("Messages").doc(usermodel["Message_channels"][index]).snapshots(),
                    builder: (context, snapshot) {
                      print(">>>>>>>>>>>>>>>>>>>>>chat list");
                      int readCount=0;
                      int count=0;
                      String Name='',profileUrl="";
                      if(snapshot.hasData){

                        readCount= snapshot.data?.data()!["Messages"].length;
                        count= int.parse("${snapshot.data?.data()![usermodel["Email"].toString().split("@")[0]]["Read_Count"]}");
                        if(snapshot.data!.data()?["${usermodel["Email"].toString().split("@")[0]}"]["Active"] == true){
                          markFalse();
                        }
                        if(snapshot.data!.data()!["Type"] == "Personal"){
                          if(snapshot.data!.data()!["Members"][0]==usermodel["Email"]){
                            Name=snapshot.data!.data()![snapshot.data!.data()!["Members"][1].toString().split("@")[0]]["Name"];
                            profileUrl=snapshot.data!.data()![snapshot.data!.data()!["Members"][1].toString().split("@")[0]]["Profile_URL"].toString();
                          }
                          else{
                            Name=snapshot.data!.data()![snapshot.data!.data()!["Members"][0].toString().split("@")[0]]["Name"];
                            profileUrl=snapshot.data!.data()![snapshot.data!.data()!["Members"][0].toString().split("@")[0]]["Profile_URL"] ?? "";
                          }
                        }
                      }
                    return snapshot.hasData
                        ?
                    snapshot.data!.data()!["Type"] == "Personal"
                        ?
                    InkWell(
                      onTap: () async {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return ChatPage(channel: usermodel["Message_channels"][index]);
                        },));
                      },
                      child: SizedBox(
                        height: size.height*0.11,
                        width: size.width*0.22,
                        child:  Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width*0.005,),
                              CircleAvatar(
                                backgroundColor: const Color.fromRGBO(86, 149, 178, 1),
                                maxRadius: size.width*0.015,
                                minRadius: size.width*0.01,
                                backgroundImage: (profileUrl != "null" || profileUrl!="") ? NetworkImage(profileUrl) : null,
                                child: (profileUrl == "null" || profileUrl == "")
                                    ?
                                AutoSizeText(
                                  Name.substring(0,1),
                                  style: GoogleFonts.tiltNeon(
                                      color: Colors.black,
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.w600),
                                )
                                    : null,
                              ),

                              SizedBox(width: size.width*0.005),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    Name,
                                    style: GoogleFonts.tiltNeon(color: Colors.black,fontSize: size.width*0.004,fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: size.width*0.1,
                                        child: AutoSizeText("${
                                            snapshot.data?.data()!["Messages"].length >0
                                                ?
                                            snapshot.data!.data()!["${snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["UID"].toString().split("@")[0]}"]['Name']
                                                :
                                            ""
                                        } : ${
                                            snapshot.data?.data()!["Messages"].length > 0
                                                ?
                                            snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"].length <25 ? snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"] : snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"].toString().substring(0,25)
                                                :
                                            ""
                                        }",
                                          style: GoogleFonts.tiltNeon(
                                              color: Colors.black.withOpacity(0.80),
                                              fontSize: size.width*0.001,
                                              fontWeight: FontWeight.w500
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(width: size.width*0.005,),
                                      readCount - count>0
                                          ?
                                      CircleAvatar(
                                        minRadius: size.width*0.0007,
                                        maxRadius: size.width*0.007,
                                        backgroundColor: Colors.green,
                                        child: AutoSizeText("${readCount - count}",
                                          style: GoogleFonts.tiltNeon(
                                              color: Colors.white,
                                              fontSize: size.width*0.007,
                                              fontWeight: FontWeight.w500
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                          :
                                      const SizedBox(),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                    )
                    :
                    InkWell(
                      onTap: () async {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return ChatPage(channel: usermodel["Message_channels"][index]);
                        },));
                      },
                      child: SizedBox(
                        height: size.height*0.11,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width*0.005,),
                              CircleAvatar(
                                backgroundColor: const Color.fromRGBO(86, 149, 178, 1),
                                maxRadius: size.width*0.015,
                                minRadius: size.width*0.01,
                                backgroundImage: (snapshot.data!.data()!["image_URL"]!="null" && snapshot.data!.data()!["image_URL"]!=null)? NetworkImage(snapshot.data!.data()!["image_URL"]) : null,
                                child: (snapshot.data?.data()!["image_URL"] == "null" || snapshot.data!.data()!["image_URL"] ==null)
                                    ?
                                AutoSizeText(
                                  usermodel["Message_channels"][index].toString().split(" ")[6].substring(0, 1),
                                  style: GoogleFonts.tiltNeon(
                                      color: Colors.black,
                                      fontSize: size.height * 0.03,
                                      fontWeight: FontWeight.w600),
                                )
                                    : null,
                              ),

                              SizedBox(width: size.width*0.005),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                  usermodel["Message_channels"][index],
                                    style: GoogleFonts.tiltNeon(color: Colors.black,fontSize: size.width*0.004,fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [

                                      SizedBox(
                                        width: size.width*0.1,
                                        child: AutoSizeText("${
                                            snapshot.data?.data()!["Messages"].length >0
                                                ?
                                            snapshot.data!.data()!["${snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["UID"].toString().split("@")[0]}"]['Name']
                                                :
                                            ""
                                        } : ${
                                            snapshot.data?.data()!["Messages"].length > 0
                                                ?
                                            snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"].length <25 ? snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"] : snapshot.data?.data()!["Messages"][snapshot.data?.data()!["Messages"].length-1]["text"].toString().substring(0,20)
                                                :
                                            ""
                                        }",
                                          style: GoogleFonts.tiltNeon(
                                              color: Colors.black.withOpacity(0.80),
                                              fontSize: size.width*0.006,

                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(width: size.width*0.05,),
                                      readCount - count>0
                                          ?
                                      CircleAvatar(
                                        backgroundColor: Colors.green,
                                        minRadius: size.width*0.0007,
                                        maxRadius: size.width*0.007,
                                        child: AutoSizeText("${readCount - count}",
                                          style: GoogleFonts.tiltNeon(
                                              color: Colors.white,
                                              fontSize: size.width*0.007,
                                              fontWeight: FontWeight.w500
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                          :
                                      const SizedBox(),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        :
                    const CircularProgressIndicator(color: Colors.amber,);
                  }
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  Future<void> markFalse() async {
    for(var channel in usermodel["Message_channels"]){
      await FirebaseFirestore.instance.collection("Messages").doc(channel).update({
        "${usermodel["Email"].toString().split("@")[0]}.Active" : false
      });
    }
    print(".....................false");
  }
}
