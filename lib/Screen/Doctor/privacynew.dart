import 'dart:convert';

import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../../Helper/Color.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  var privacyResult ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrivacy () ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        centerTitle: true,
        title: Text("Privacy Policy"),),
         body:privacyResult !=null ? Html(data: privacyResult["data"][0]["value"])
        : Container(child: Center(child: CircularProgressIndicator()),),
    );
  }


  Future<void> getPrivacy ()async{

    var request = http.Request('GET', getDoctorUpdatePrivacyPolicy);

    request.headers.addAll(doctorHeader);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      privacyResult = jsonDecode(result);
      setState((){

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}


