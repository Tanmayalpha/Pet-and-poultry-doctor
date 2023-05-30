import 'dart:async';
import 'dart:convert';


import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Helper/chat_page.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/doctor_diagnosed_response.dart';
import 'package:eshopmultivendor/Screen/Doctor/video_call.dart';
import 'package:eshopmultivendor/Screen/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DiagnosedDataScreen extends StatefulWidget {
  const DiagnosedDataScreen({Key? key}) : super(key: key);

  @override
  State<DiagnosedDataScreen> createState() => _DiagnosedDataScreenState();
}

class _DiagnosedDataScreenState extends State<DiagnosedDataScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDiagnosedData();
   // setupVideoSDKEngine();
    //updateFid(widget.userFueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            "assets/logo/food_on_the_way.png",
            height: 70,
          ),
          backgroundColor: white,
          iconTheme: IconThemeData(color: grad2Color),),

         body: isLoading? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: latest.length,
          itemBuilder: (BuildContext context, int index) {
            var item = latest[index];
            return InkWell(
              onTap: () {


              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: white,
                    elevation: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Pet_Owner") ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item.username ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Email") ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item.email ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Owner_Contact") ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item.mobile ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Breeds") ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item.breed ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Disease") ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(item.disease ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Status") ?? "Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 8,bottom: 8,right: 15,left: 15),

                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(checkStatue(item.status ?? '',), style: TextStyle(color: white),),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "Support") ??"Support",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: (){
                                  if(item.fuid!=null&&item.fuid!=""&&item.fuid!.length>20){
                                    callChat(item);
                                  }else{

                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 8,bottom: 8,right: 15,left: 15),

                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(getTranslated(context, "Chat") ??'Chat', style: TextStyle(color: white),),),
                              ),
                            ],
                          ),
                        ),
                        //getVideoCallView(),



                        /*Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        "Accept",
                                        style: TextStyle(color: white),
                                      ),
                                    )),
                                Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: Center(
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(color: white),
                                        ))),
                              ],
                            ),
                          ),*/
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }

  String checkStatue(String status){
    if(status== '0'){
      return 'Pending';
    }else if(status== '1'){
      return 'Accepted';
    }else if(status== '2'){
      return 'Rejected';
    }else if(status== '3'){
      return 'Diagnosed';
    }else {
      return 'Approved';
    }
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool chatLoading = false;
  callChat(Accepted model) async {

    print("fuid" + model.fuid.toString());
    var otherUser1 = types.User(
      firstName: model.name,
      id: model.fuid.toString(),
      imageUrl: 'https://i.pravatar.cc/300?u=${model.email}',
      lastName: "",
    );
    _handlePressed(otherUser1, context, model.fuid.toString(), model);
  }

  _handlePressed( types.User otherUser, BuildContext context, String fcmID,
      Accepted model) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    setState(() {
      chatLoading = false;
    });
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
          fcm: fcmID,
          id: model.userId!,
          name: model.username!,
        ),
      ),
    );
  }
  List<Accepted> latest = [];
  bool isLoading = false ;

Future <void> getDiagnosedData()async{

  setState(() {
    bool isLoading = true;
  });

  CUR_USERID = await getPrefrence(UserId);

  var parameter = {UserId: CUR_USERID};
  apiBaseHelper.doctorPostAPICall(getDoctorDiagnosedRequest, parameter).then(
          (getData) {

            bool error = getData["error"];
            String? msg = getData["message"];

            if (!error) {
              latest = DoctorDiagnosedRequstResonse.fromJson(jsonDecode(jsonEncode(getData))).data?.accepted ?? [];



              setState(() {
                isLoading = false;
              });
            }

      });

}


//////////////////////////////////======================AgoraVideo call code========================///////////////////////////////////////////////

  /*Widget getVideoCallView(){
  return Column(children: [
    Container(
      height: 240,
      decoration: BoxDecoration(border: Border.all()),
      child: Center(child: _localPreview()),
    ),
    const SizedBox(height: 10),
    Container(
      height: 240,
      decoration: BoxDecoration(border: Border.all()),
      child: Center(child: _remoteVideo()),
    ),
    Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: _isJoined ? null : () => {join()},
            child: const Text("Join"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: _isJoined ? () => {leave()} : null,
            child: const Text("Leave"),
          ),
        ),
      ],
    ),
  ],);
  }


  String channelName = "test123";
  String token = "ac9cefbedca640a195c1f2b4f01a3a48";

  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
  = GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold

  showMessage(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Widget _localPreview() {
    if (_isJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
        ),
      );
    } else {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelName),
        ),
      );
    } else {
      String msg = '';
      if (_isJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
   // await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: "1e8f86f7bc9947eab9b6e67f227e440f"
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }


  void  join() async {
    await agoraEngine.startPreview();

    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }*/


}

