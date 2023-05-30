import 'dart:convert';

import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;


class TNC extends StatefulWidget {
  const TNC({Key? key}) : super(key: key);

  @override
  State<TNC> createState() => _TNCState();
}


class _TNCState extends State<TNC> {
  var termsConditionResult ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTerms ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon:Icon(Icons.arrow_back), color: white,),
        backgroundColor: primary,
        centerTitle: true,
        title: Text(getTranslated(context, "T_AND_C")!, style: TextStyle(color: white),),),
      body: termsConditionResult !=null ? Html(data: termsConditionResult["data"][0]["value"])
          : Container(child: Center(child: CircularProgressIndicator()),),
    );
  }

  Future<void> getTerms ()async{

    var request = http.Request('GET', getDoctorUpdateTermCondition);

    request.headers.addAll(doctorHeader);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result =await response.stream.bytesToString();
      termsConditionResult = jsonDecode(result);
      setState((){

      });
    }
    else {
      print(response.reasonPhrase);
    }

  }

}
