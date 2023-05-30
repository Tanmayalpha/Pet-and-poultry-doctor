import 'dart:ui';

import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Screen/Doctor/prescribe_view.dart';
import 'package:eshopmultivendor/Screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AnimalDetailScreen extends StatefulWidget {
  AnimalDetailScreen({Key? key,
    this.animalDetail,
    this.isFromApproved,
    this.userFueId,
    this.userFcmToken})
      : super(key: key);

  var animalDetail;
  bool? isFromApproved;

  String? userFueId;
  String? userFcmToken;

  @override
  State<AnimalDetailScreen> createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  String? usertype;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserType();
    getProduct();
  }

  getuserType() async {
    usertype = await getPrefrence(UserType);
    setState(() {});
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
        iconTheme: IconThemeData(color: grad2Color),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Text('Owner Information',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Username :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Email :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Mobile :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 5),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              widget.animalDetail?.username == null ||
                                  widget.animalDetail?.username == ""
                                  ? Text('N/A')
                                  : Container(
                                  alignment: Alignment.topRight,
                                  width: 110,
                                  child: Text(
                                    '${widget.animalDetail?.username}',
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(height: 5),
                              widget.animalDetail?.email == null ||
                                  widget.animalDetail?.email == ""
                                  ? Text('N/A')
                                  : Container(
                                  alignment: Alignment.topRight,
                                  width: 115,
                                  child: Text(
                                    '${widget.animalDetail?.email}',
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(height: 5),
                              widget.animalDetail?.mobile == null ||
                                  widget.animalDetail?.mobile == ""
                                  ? Text('N/A')
                                  : Container(
                                  alignment: Alignment.topRight,
                                  width: 115,
                                  child: Text(
                                      '${widget.animalDetail?.mobile}')),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Row(children: [
                    //   Text('Mobile:'),
                    //   SizedBox(width: 8),
                    //   Text('${widget.animalDetail?.mobile}'),
                    // ],),
                    SizedBox(height: 16),*/
                    /*Text('Animal Information',
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Gender :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Age :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Weight :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Breed :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 5),
                              Text('Species :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              widget.animalDetail?.name == null ||
                                  widget.animalDetail?.name == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 90,
                                  child: Text('${widget.animalDetail?.name}',overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 5),
                              widget.animalDetail?.gender == null ||
                                  widget.animalDetail?.gender == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 90,
                                  child: Text('${widget.animalDetail?.gender}',overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 5),
                              widget.animalDetail?.age == null ||
                                  widget.animalDetail?.age == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 20,
                                  child: Text('${widget.animalDetail?.age}',overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 5),
                              widget.animalDetail?.weight == null ||
                                  widget.animalDetail?.weight == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 20,
                                  child: Text('${widget.animalDetail?.weight}',overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 5),
                              widget.animalDetail?.breed == null ||
                                  widget.animalDetail?.breed == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 90,
                                  child: Text('${widget.animalDetail?.breed}',overflow: TextOverflow.ellipsis,)),
                              SizedBox(height: 5),
                              widget.animalDetail?.species == null ||
                                  widget.animalDetail?.species == ""
                                  ? Text('N/A')
                                  : Container(
                                  width: 90,
                                  child: Text('${widget.animalDetail?.species}',overflow: TextOverflow.ellipsis,)),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),*/
                    Text(getTranslated(context, 'General Information') ?? '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated(context, 'Name_of_Pet') ??'Name of Pet',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Type_of_Pet') ??'Type of Pet ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Breed_of_Pet') ??'Breed of Pet :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Sex_of_Pet') ??'Sex of Pet :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Pregnant') ??'Pregnant',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Age_of_Pet') ??'Age of Pet',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Temperature') ??'Temperature',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Weight_of_Pet') ??'Weight of Pet :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Body_Weight_Changes') ??'Body Weight Changes',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Feed_Consumption_per_Day') ??'Feed Consumption per Day :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Water_Consumption_per_Day') ??'Water Consumption per Day :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Average_Milk_Production') ??'Average Milk Production :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Calving History') ??'Calving History :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Vaccination') ??'Vaccination',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Vaccine_Name') ??'Vaccine Name',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Medication') ??'Medication :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Medicine') ??'Medicine',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Surgery') ??'Surgery',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Type_of_Surgery') ??'Type of Surgery :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Travelling_History') ??'Travelling History',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Symptoms') ??'Symptoms',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Stool_Consistency') ??'Stool Consistency',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Stool_Color') ??'Stool Color',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Urine_Frequency') ??'Urine Frequency',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Urine_Color') ??'Urine Color :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Any_Change_in_Weather') ??'Any Change in Weather',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                              Text(getTranslated(context, 'Weather') ??'Weather :',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                widget.animalDetail?.json?.nameOfPet == null ||
                                    widget.animalDetail?.json?.nameOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  width: 90,
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '${widget.animalDetail?.json?.nameOfPet}',
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.typeOfPet == null ||
                                    widget.animalDetail?.json?.typeOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,

                                    width: 90,
                                    child: Text(
                                        '${widget.animalDetail?.json
                                            ?.typeOfPet}',
                                        overflow: TextOverflow.ellipsis)),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.breedOfPet == null ||
                                    widget.animalDetail?.json?.breedOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,

                                  width: 90,
                                  child: Text(
                                    '${widget.animalDetail?.json?.breedOfPet}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.sexOfPet == null ||
                                    widget.animalDetail?.json?.sexOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,

                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.sexOfPet}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.pregnant == null ||
                                    widget.animalDetail?.json?.pregnant ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,

                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.pregnant}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.ageOfPet == null ||
                                    widget.animalDetail?.json?.ageOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,

                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.ageOfPet}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.temperature ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.temperature ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  width: 90,
                                  alignment: Alignment.topRight,

                                  child: Text(
                                  '${widget.animalDetail?.json?.temperature}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                    ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.weightOfPet ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.weightOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 30,
                                  child: Text(
                                    '${widget.animalDetail?.json?.weightOfPet}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.bodyWeightChanges ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.bodyWeightChanges ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 30,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.bodyWeightChanges}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json
                                    ?.feedConsumptionPerDay ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.feedConsumptionPerDay ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 30,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.feedConsumptionPerDay}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json
                                    ?.waterConsumptionPerDay ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.waterConsumptionPerDay ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 25,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.waterConsumptionPerDay}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.avgMilkProduction ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.avgMilkProduction ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 90,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.avgMilkProduction}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.calvingHistory ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.calvingHistory ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 90,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.calvingHistory}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.vaccination ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.vaccination ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 25,
                                  child: Text(
                                    '${widget.animalDetail?.json?.vaccination}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.vaccineName ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.vaccineName ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 25,
                                  child: Text(
                                    '${widget.animalDetail?.json?.vaccineName}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.medication == null ||
                                    widget.animalDetail?.json?.medication ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 25,
                                  child: Text(
                                    '${widget.animalDetail?.json?.medication}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.medicine == null ||
                                    widget.animalDetail?.json?.medicine ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,
                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.medicine}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.surgery == null ||
                                    widget.animalDetail?.json?.surgery == ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,
                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.surgery}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.typeOfPet == null ||
                                    widget.animalDetail?.json?.typeOfPet ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,
                                    width: 90,
                                    child: Text(
                                      '${widget.animalDetail?.json?.typeOfPet}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.travellingHistory ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.travellingHistory ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 90,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.travellingHistory}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.symptoms == null ||
                                    widget.animalDetail?.json?.symptoms ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,
                                    width: 55,
                                    child: Text(
                                      '${widget.animalDetail?.json?.symptoms}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.stoolConsitancy ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.stoolConsitancy ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 55,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.stoolConsitancy}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.stoolColor == null ||
                                    widget.animalDetail?.json?.stoolColor ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 50,
                                  child: Text(
                                    '${widget.animalDetail?.json?.stoolColor}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.urineFrequency ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.urineFrequency ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 60,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.urineFrequency}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.urineColor == null ||
                                    widget.animalDetail?.json?.urineColor ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 90,
                                  child: Text(
                                    '${widget.animalDetail?.json?.urineColor}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.anyChangeWeather ==
                                    null ||
                                    widget.animalDetail?.json
                                        ?.anyChangeWeather ==
                                        ""
                                    ? Text("N/A")
                                    : Container(
                                  alignment: Alignment.topRight,
                                  width: 30,
                                  child: Text(
                                    '${widget.animalDetail?.json
                                        ?.anyChangeWeather}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                widget.animalDetail?.json?.weather == null ||
                                    widget.animalDetail?.json?.weather == ""
                                    ? Text("N/A")
                                    : Container(
                                    alignment: Alignment.topRight,
                                    width: 30,
                                    child: Text(
                                      '${widget.animalDetail?.json?.weather}',
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Text('Photos'),


                    usertype == '0'
                        ? widget.isFromApproved ?? false
                        ? SizedBox()
                        : AppButton(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PrescribeScreen(
                                    age: widget
                                        .animalDetail?.json?.ageOfPet,
                                    petName: widget
                                        .animalDetail?.json?.nameOfPet,
                                    weight: widget
                                        .animalDetail?.json?.weightOfPet,
                                    clientName:
                                    widget.animalDetail?.username,
                                    id: widget.animalDetail?.id,
                                  ),
                            ));
                      },
                      titleText: getTranslated(context, 'Diagnosis') ?? '',
                    )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            usertype=='0' ? SizedBox():  Align(
              alignment: Alignment.topLeft,
              child: Text(
                getTranslated(context, 'Prescription') ??'Prescription:',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
             usertype=='0' ? SizedBox() : priscriptionView(widget.animalDetail?.diagnosis),

            usertype=='0' ? SizedBox() : Align(
              alignment: Alignment.topLeft,
              child: Text(
                getTranslated(context, 'Prescribed_Medicine') ??'Prescribed Medicine:',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
            data == null ?SizedBox() : usertype=='0' ? SizedBox() : medecineView(),
          ],
        ),
      ),
    );
  }

  Widget medecineView() {
    return Card(
        child: Padding(
        padding: const EdgeInsets.all(8.0),
    child: Column(
    children: List.generate(
    data.length,
    (index) => ListTile(leading:Image.network(data[index]["image"],),title: Text(data[index]["name"],),
    ),
    ),
    )));
  }

  var data;

  getProduct() async {
    var parameter = {Id: widget.animalDetail.medicines};

    print("_______${parameter}_______");
    apiBaseHelper
        .doctorPostAPICall(getProductsRequest, parameter)
        .then((getData) {
      //latestList.removeWhere((element) => element.id == id);
      data = getData["data"];

      print("_______${data}_______");

      setState(() {});
    });
  }

  Widget priscriptionView (String diagnosis){
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: primary) ),
        child: Text(diagnosis, maxLines: null,),),
    );
  }
}
/*
usertype == '0' ? widget.isFromApproved ?? false ? SizedBox() : AppButton(onTap: () {
Navigator.push(context, MaterialPageRoute(
builder: (context) =>
PrescribeScreen(age: widget.animalDetail?.json
    ?.ageOfPet, petName: widget.animalDetail?.json
    ?.nameOfPet,weight: widget.animalDetail?.json?.weightOfPet,clientName:widget.animalDetail?.username, id: widget.animalDetail?.id, ),));
}, titleText: 'Diagnosis',) : SizedBox(),*/
