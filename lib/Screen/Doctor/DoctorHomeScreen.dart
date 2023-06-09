import 'dart:async';
import 'dart:convert';

import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Constant.dart';
import 'package:eshopmultivendor/Localization/Language_Constant.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/DiagnosedRequestResponse.dart';
import 'package:eshopmultivendor/Screen/Doctor/AnimalDetailScreen.dart';
import 'package:eshopmultivendor/Screen/Authentication/Login.dart';
import 'package:eshopmultivendor/Screen/Doctor/request_for_withdraw.dart';
import 'package:eshopmultivendor/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../Helper/Session.dart';
import '../../Helper/String.dart';
import '../../Model/DocterRegisterModel/patient_request_response.dart';
import '../Add_Product.dart';
import '../Customers.dart';
import '../OrderList.dart';
import '../ProductList.dart';
import '../Profile.dart';

import '../WalletHistory.dart';
import '../contactusnew.dart';
import '../daily_collection.dart';
import 'DiagnosedHistoryScreen.dart';
import 'privacynew.dart';
import 'tncnew.dart';
import '../transaction.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}


class _DoctorHomeScreenState extends State<DoctorHomeScreen>
    with TickerProviderStateMixin {
  int curDrwSel = 0;

  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  bool isLoading = false;





  //==============================================================================
//============================ AppBar ==========================================

  getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        "assets/logo/food_on_the_way.png",
        height: 70,
      ),
      backgroundColor: white,
      iconTheme: IconThemeData(color: grad2Color),
      bottom: TabBar(

        controller: tabController,
        isScrollable: false,
        indicatorColor: primary,
        onTap: (int index) {
          tabController!.animateTo(index);

          print("_______${userType}_______");

          if (userType == '0') {
            getRequest();
          } else {
            getDiagnosedRequest();
          }
        },


        tabs: [
          Tab(
            child: SizedBox(width: MediaQuery
                .of(context)
                .size
                .width / 3, child: Center(child: Text(getTranslated(context, 'Latest') ??'Latest')),),
          ),
          Tab(
              child: SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .width / 3,
                child: Center(child: userType == '0' ? Text(getTranslated(context, 'ACCEPTED') ??'Accepted') : Text(
                    getTranslated(context, 'Approved') ??'Approved')),)
          ),
        ],
      ),

      actions: [
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     onOf ? Text("Online") : Text("Offline"),
        //   ],
        // ),
        // CupertinoSwitch(
        //     trackColor: primary,
        //     value: onOf,
        //     onChanged: (value) {
        //       setState(() {
        //         onOf = value;
        //         shopStatus();
        //       });
        //     })
      ],
    );
  }

  TabController? tabController;

  String? userType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getProfile();
    callChat();
    if (userType == '0') {
      getRequest();

    } else {
      getDiagnosedRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      drawer: getDrawer(context),
      // appBar: AppBar(centerTitle: true,
      // automaticallyImplyLeading: false,
      //
      // title: Image.asset("assets/logo/food_on_the_way.png",height: 70,),
      // backgroundColor: white,),
      body: isLoading
          ? Center(child: CircularProgressIndicator(),)
          : TabBarView(
        physics: NeverScrollableScrollPhysics(),

        controller: tabController,
        children: [
          userType == '0' ? latestList.isEmpty ? Center(child: Text(getTranslated(context, "Not_any_request_available") ?? ''),) : SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: latestList.length,
              itemBuilder: (BuildContext context, int index) {
                var item = latestList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          AnimalDetailScreen(animalDetail: item,
                              isFromApproved: true,userFueId: item.fuid, userFcmToken: item.fcmID),));
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
                                    getTranslated(context, "Name_of_Pet") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.nameOfPet ?? ''),
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
                                    getTranslated(context, 'Weight_of_Pet') ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.weightOfPet ?? ''),
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
                                    getTranslated(context, "Age_of_Pet") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.ageOfPet ?? ''),
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
                                  top: 10.0, left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    getTranslated(context, "Consult_Type") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(checkConsultType(item.consulType ?? '',), style: TextStyle(color: white),),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      acceptRejectRequest(item.id ?? '', '1');
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            color: Colors.green),
                                        child: Center(
                                          child: Text(
                                            getTranslated(context, 'ACCEPT') ?? '',
                                            style: TextStyle(color: white),
                                          ),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      acceptRejectRequest(item.id ?? '', '2');
                                    },
                                    child: Container(
                                        height: 35,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                            color: Colors.red),
                                        child: Center(
                                            child: Text(
                                              getTranslated(context, 'REJECT') ?? '',
                                              style: TextStyle(color: white),
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ) : seniorDocLatestView(),
          userType == '0' ? acceptedList.isEmpty ? Center(child: Text(getTranslated(context, "Not_any_request_available") ?? ''),) : SingleChildScrollView(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: acceptedList.length,
              itemBuilder: (BuildContext context, int index) {
                var item = acceptedList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          AnimalDetailScreen(animalDetail: item),));
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
                                    getTranslated(context, "Name_of_Pet") ??'',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.nameOfPet ?? ''),
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
                                    getTranslated(context, 'Weight_of_Pet') ??"Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.weightOfPet ?? ''),
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
                                    getTranslated(context, "Age_of_Pet") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.json?.ageOfPet ?? ''),
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
                                  top: 10.0, left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    getTranslated(context, "Status") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                        color: primary,
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
                                    getTranslated(context, "Consult_Type") ?? '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(checkConsultType(item.consulType ?? '',), style: TextStyle(color: white),),),
                                ],
                              ),
                            ),
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
          ) : seniorDocApprovedView(),
        ],),
    );
  }

  getDrawer(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: white,
          child: ListView(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              _getHeader(),
              Divider(),
              _getDrawerItem(
                  0, getTranslated(context, "HOME")!, Icons.home_outlined),
              // _getDrawerItem(1, getTranslated(context, "ORDERS")!,
              //     Icons.shopping_basket_outlined),
              Divider(),
              // _getDrawerItem(
              //     2, getTranslated(context, "CUSTOMERS")!, Icons.person),
              _getDrawerItem(11, getTranslated(context, "WALLET") ?? '',
                  Icons.account_balance_wallet_outlined),
              // _getDrawerItem(11, "Daily Collection", Icons.account_balance_wallet_outlined),
              userType != '0' ? SizedBox() :_getDrawerItem(12, getTranslated(context, "Diagnosed") ?? '', Icons.compare_arrows_sharp),
              // Divider(),
              // _getDrawerItem(4, getTranslated(context, "PRODUCTS")!,
              //     Icons.production_quantity_limits_outlined),
              // _getDrawerItem(10, "Add Product", Icons.add),
              // Divider(),
              _getDrawerItem(5, getTranslated(context, "ChangeLanguage")!,
                  Icons.translate),
              _getDrawerItem(6, getTranslated(context, "T_AND_C")!,
                  Icons.speaker_notes_outlined),
              Divider(),
              _getDrawerItem(7, getTranslated(context, "PRIVACYPOLICY")!,
                  Icons.lock_outline),
              _getDrawerItem(
                  9, getTranslated(context, "CONTACTUS")!, Icons.contact_page),
              Divider(),
              _getDrawerItem(
                  8, getTranslated(context, "LOGOUT")!, Icons.home_outlined),
            ],
          ),
        ),
      ),
    );
  }

  _getDrawerItem(int index, String title, IconData icn) {
    return Container(
      margin: EdgeInsets.only(
        right: 20,
      ),
      decoration: BoxDecoration(
        gradient: curDrwSel == index
            ? LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [secondary.withOpacity(0.2), primary.withOpacity(0.2)],
          stops: [0, 1],
        )
            : null,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icn,
          color: curDrwSel == index ? primary : lightBlack2,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: curDrwSel == index ? primary : lightBlack2, fontSize: 15),
        ),
        onTap: () {
          if (title == getTranslated(context, "HOME")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
          } else if (title == getTranslated(context, "ORDERS")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderList(),
              ),
            );
          } else if (title == getTranslated(context, "CUSTOMERS")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Customers(),
              ),
            );
          } else if (title == getTranslated(context, "WALLETHISTORY")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WalletHistory(),
              ),
            );
          } else if (title == "Daily Collection") {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyCollection(),
              ),
            );
          } else if (title == "Transaction") {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionDetails(),
              ),
            );
          } else if (title == getTranslated(context, "PRODUCTS")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductList(
                      flag: '',
                    ),
              ),
            );
          } else if (title == getTranslated(context, "ChangeLanguage")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            openChangeLanguageBottomSheet();
            // languageDialog();
          } else if (title == getTranslated(context, "T_AND_C")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TNC(),
              ),
            );
          } else if (title == getTranslated(context, "CONTACTUS")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Contact(),
              ),
            ).then((value) {
              setState(() {});
            });
          } else if (title == getTranslated(context, "PRIVACYPOLICY")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Privacy(),
              ),
            );
          } else if (title == getTranslated(context, "LOGOUT")!) {
            Navigator.pop(context);
            logOutDailog();
          } else if (title == getTranslated(context, "Diagnosed")) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiagnosedDataScreen(),
              ),
            );
          }else if (title == "Add Product") {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProduct(),
              ),
            );
          } else {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WithdrawRequestScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  final GlobalKey<FormState> _changePwdKey = GlobalKey<FormState>();

  Widget bottomsheetLabel(String labelName) => Padding(
    padding: const EdgeInsets.only(top: 30.0, bottom: 20),
    child: getHeading(labelName),
  );
  Widget getHeading(String title) {
    return Text(
      getTranslated(context, title)!,
      style: Theme.of(context).textTheme.headline6!.copyWith(
          fontWeight: FontWeight.bold,
          color: white),
    );
  }
//  => Drawer Header
  List<String> langCode = ["en","hi","mr" /*"zh", "es",  "ar", "ru", "ja", "de"*/];
  List<String?> themeList = [];
  List<String?> languageList = ["English", "Hindi", "Marathi"];
  int? selectLan ;
  void openChangeLanguageBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Form(
                  key: _changePwdKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      bottomSheetHandle(),
                      bottomsheetLabel("CHOOSE_LANGUAGE_LBL"),
                      StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: getLngList(context, setModalState)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
  List<Widget> getLngList(BuildContext ctx, StateSetter setModalState) {
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
          index,
          InkWell(
            onTap: () {
              if (mounted)
                setState(() {
                  selectLan = index;
                  _changeLan(langCode[index], ctx);
                });
              setModalState(() {});
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index
                                ? primary2
                                : white,
                            border: Border.all(color: primary2)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: selectLan == index
                              ? Icon(
                            Icons.check,
                            size: 17.0,
                            color: white,
                          )
                              : Icon(
                            Icons.check_box_outline_blank,
                            size: 15.0,
                            color:
                            white,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index]!,
                            style: Theme.of(this.context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                color: black),
                          ))
                    ],
                  ),
                  // index == languageList.length - 1
                  //     ? Container(
                  //         margin: EdgeInsetsDirectional.only(
                  //           bottom: 10,
                  //         ),
                  //       )
                  //     : Divider(
                  //         color: Theme.of(context).colorScheme.lightBlack,
                  //       ),
                ],
              ),
            ),
          )),
    )
        .values
        .toList();
  }
  Widget bottomSheetHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: black),
        height: 5,
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }

  void _changeLan(String language, BuildContext ctx) async {
    Locale _locale = await setLocale(language);

    MyApp.setLocale(ctx, _locale);
  }

  _getHeader() {
    return InkWell(
      child: Container(
        decoration: back(),
        padding: EdgeInsets.only(left: 10.0, bottom: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CUR_USERNAME!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: white, fontWeight: FontWeight.bold),
                  ),
                  /*Text(
                    getTranslated(context, "WALLET_BAL")! +
                        ": " +
                        CUR_CURRENCY +
                        "" +
                        CUR_BALANCE,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: white),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 7,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getTranslated(context, "EDIT_PROFILE_LBL")!,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: white),
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          color: white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0,
                  color: white,
                ),
              ),
              child: LOGO != ''
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: profilePhoto(62),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: imagePlaceHolder(62),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        ).then((value) {
          print("back frome profile screen");
          // getStatics();
          // getSallerDetail();
          // //  getDeliveryBoy();
          // getZipCodes();
          // getCategories();
          setState(() {});
          Navigator.pop(context);
          getProfile();
          setState(() {});
        });
        setState(() {});
      },
    );
  }

  profilePhoto(double size) {
    return CircleAvatar(
      backgroundImage: NetworkImage(LOGO),
      radius: 25,
    );
  }

  imagePlaceHolder(double size) {
    return new Container(
      height: size,
      width: size,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: size,
      ),
    );
  }

  logOutDailog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: Text(
                getTranslated(context, "LOGOUTTXT")!,
                style: Theme
                    .of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: fontColor),
              ),
              actions: <Widget>[
                new TextButton(
                    child: Text(
                      getTranslated(context, "LOGOUTNO")!,
                      style: Theme
                          .of(this.context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                          color: lightBlack, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                new TextButton(
                  child: Text(
                    getTranslated(context, "LOGOUTYES")!,
                    style: Theme
                        .of(this.context)
                        .textTheme
                        .subtitle2!
                        .copyWith(
                        color: fontColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    clearUserSession();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false);
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> getProfile() async {
    CUR_USERID = await getPrefrence(UserId);
    userType = await getPrefrence(UserType);

    var parameter = {UserId: CUR_USERID};
    apiBaseHelper.doctorPostAPICall(getDoctorProfile, parameter).then(
          (getdata) async {
        print("_______${parameter}_______");
        bool error = getdata["error"];
        String? msg = getdata["message"];

        if (!error) {
          var data = getdata["data"][0];
          print(data);
          //CUR_BALANCE = double.parse(data[BALANCE]).toStringAsFixed(2);
          LOGO = data["image"].toString();
          //RATTING = data[Rating] ?? "";
          // NO_OFF_RATTING = data[NoOfRatings] ?? "";
          //NO_OFF_RATTING = data[NoOfRatings] ?? "";
          var id = data[Id];
          var username = data[Username];
          var email = data[Email];
          var mobile = data[Mobile];
          var address = data[Address];
          var registeration_no = data[RegistrationNo];
          var userType = data[UserType];
          CUR_USERID = id!;
          CUR_USERNAME = username!;
          var idCard = data[IdCard];
          var degreeFile = data[DegreeFile];
          var certificate = data[Certificate];
          var accNo = data[accountNumber];
          var accname = data[accountName];
          var bankCode = data[BankCOde];
          var bankName = data[bankNAme];
          var latitutute = data[Latitude];
          var longitude = data[Longitude];
          var cheque = data[Cheque];
          var tax_number = "";
          var pan_number = "";
          var status = "";
          var signature = data[Signature];
          var degreeName = data[DegreeName];

          // onOf = data["online"] == "0" ? false : true;

          print("bank name : $bankName");
          saveUserDetail(
              id!,
              username!,
              email!,
              mobile!,
              address!,
              idCard!,
              degreeFile!,
              certificate!,
              accNo!,
              accname!,
              bankCode ?? "",
              bankName ?? "",
              latitutute ?? "",
              longitude ?? "",
              cheque ?? "",
              tax_number ?? '',
              pan_number ?? '',
              status ?? '',
              signature ?? '',
              registeration_no,
              degreeName ?? '',
              usertype: userType);
        } else {
          if (mounted)
            setState(() {
              //_isNetworkAvail = false;
              //_isLoading = false;
            });
        }
        setState(() {
          //_isLoading = false;
        });
      },
      onError: (error) {
        //setSnackbar(error.toString());
      },
    );
  }

  List<Accepted> latestList = [];
  List<Accepted> acceptedList = [];
  List<Latest> acceptedDiagnosed = [];
  List<Latest> latestDiagnosed = [];

  Future<void> getRequest() async {
    print("_______${userType}_______");
    isLoading = true;
    setState(() {

    });

    CUR_USERID = await getPrefrence(UserId);

    var perameter = {UserId: CUR_USERID};

    apiBaseHelper.doctorPostAPICall(getPatientRequests, perameter).then(
            (getData) async {
          print("_______${getPatientRequests}_______");
          bool error = getData["error"];
          String? msg = getData["message"];
          print("_______${getData}_______");

          if (!error) {
            acceptedList = PatientRequstResonse
                .fromJson(jsonDecode(jsonEncode(getData)))
                .data
                ?.accepted ?? [];
            latestList = PatientRequstResonse
                .fromJson(jsonDecode(jsonEncode(getData)))
                .data
                ?.latest ?? [];

           // updateFid(acceptedList.first.fuid);

            setState(() {
              isLoading = false;
            });
          }
        });
  }

  Future<void> getDiagnosedRequest() async {
    isLoading = true;
    setState(() {});

    CUR_USERID = await getPrefrence(UserId);

    var perameter = {UserId: CUR_USERID};

    apiBaseHelper.doctorPostAPICall(getDiagnosedRequests, perameter).then(
            (getData) async {
          bool error = getData["error"];
          String? msg = getData["message"];

          if (!error) {
            acceptedDiagnosed = DiagnosedRequstResonse
                .fromJson(jsonDecode(jsonEncode(getData)))
                .data
                ?.accepted ?? [];
            latestDiagnosed = DiagnosedRequstResonse
                .fromJson(jsonDecode(jsonEncode(getData)))
                .data
                ?.latests ?? [];


            setState(() {
              isLoading = false;
            });
          }
        });
  }

  Future<void> acceptRejectRequest(String id, String status) async {
    CUR_USERID = await getPrefrence(UserId);

    var parameter = {
      UserId: CUR_USERID,
      Id: id,
      Status: status,
      'remarks':remarkController.text.isEmpty ? '': remarkController.text
    };
    apiBaseHelper.doctorPostAPICall(getAcceptRejectRequests, parameter).then((
        getData) {
      setDoctorSnackbar(getData["message"], context);
      //latestList.removeWhere((element) => element.id == id);
      if (userType == '0') {
        getRequest();
      } else {
        getDiagnosedRequest();
        Navigator.pop(context);
      }


    });
  }

  Widget seniorDocLatestView() {
    return  latestDiagnosed.isEmpty ? Center(child: Text(getTranslated(context, "Not_any_request_available") ?? ''),) : SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: latestDiagnosed.length,
        itemBuilder: (BuildContext context, int index) {
          var item = latestDiagnosed[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AnimalDetailScreen(animalDetail: item),));
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Doctor_Name")??'',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.doctorName ?? ''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Email") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.doctorEmail ?? ''),
                          ],
                        ),
                      ),

                      /*Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Medicine",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.medicines ?? ''),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Disease") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.disease ?? ''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Status") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Pending'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                remarkDialouge('4', item.id ?? '');
                              },
                              child: Container(
                                  height: 35,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green),
                                  child: Center(
                                    child: Text(
                                      getTranslated(context, "Approved") ?? '',
                                      style: TextStyle(color: white),
                                    ),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                remarkDialouge('5', item.id ?? '');
                              },
                              child: Container(
                                  height: 35,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red),
                                  child: Center(
                                      child: Text(
                                        getTranslated(context, "Unapproved") ?? '',
                                        style: TextStyle(color: white),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget seniorDocApprovedView() {
    return acceptedDiagnosed.isEmpty ? Center(child: Text(getTranslated(context, "Not_any_request_available") ?? ''),) : SingleChildScrollView(
      padding: const EdgeInsets.all(5.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: acceptedDiagnosed.length,
        itemBuilder: (BuildContext context, int index) {
          var item = acceptedDiagnosed[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => AnimalDetailScreen(animalDetail: item),));
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Doctor_Name")??'',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.doctorName ?? ''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Email") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.doctorEmail ?? ''),
                          ],
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, 'Diagnosis') ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.diagnosis ?? ''),
                          ],
                        ),
                      ),*/
                      /*Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Medicine",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.medicines ?? ''),
                          ],
                        ),
                      ),*/
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Disease") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(item.disease ?? ''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, "Status") ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),

                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(checkStatue(item.status ?? '',), style: TextStyle(color: white),),),
                          ],
                        ),
                      ),
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
    );
  }

String checkStatue(String status){
    if(status== '0'){
      return 'Pending';
    }else if(status== '1'){
      return getTranslated(context, "ACCEPTED") ??'Accepted';
    }else if(status== '2'){
      return getTranslated(context, "REJECTED") ??'Rejected';
    }else if(status== '3'){
      return getTranslated(context, "Diagnosed") ??'Diagnosed';
    }else {
      return getTranslated(context, "Approved") ?? '';
    }
}

  String checkConsultType(String status){
    if(status== '1'){
      return 'Online';
    }else {
      return 'Offline';
    }
  }


  bool loading = true;



  String email = "";



  final remarkController = TextEditingController();

  remarkDialouge(String status, String id) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              content: TextFormField(
                controller: remarkController,
                decoration: InputDecoration(hintText: getTranslated(context, 'Add_remark') ?? 'Add remark'),
              ),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    onPressed: () {
                      if (remarkController.text.isEmpty) {
                        setDoctorSnackbar("please add remark", context);
                      } else {
                        acceptRejectRequest(id, status);
                      }
                    }, child: Text(getTranslated(context, 'Submit') ?? 'Submit'))
              ],
            );
          },
        );
      },
    );
  }

  updateFid(fid) async {

    print("_______fggdggggd_______");

    CUR_USERID = await getPrefrence(UserId);
    try {
      /*setState(() {
        loading = true;
      });*/
      Map params = {
        "user_id": CUR_USERID.toString(),
        "fuid": fid,
      };
      Map response = await apiBaseHelper.postAPICall(
          Uri.parse(doctorBaseUrl + "update_fuid"), params);
      setState(() {
        //loading = false;
      });
      if (!response['error']) {

      } else {

      }
    } on TimeoutException catch (_) {
      setState(() {
        //loading = true;
      });
      print("_______errr_______");

    }
  }

  callChat() async {
    String? name = await getPrefrence(Username);
    String? email = await getPrefrence(Email);
    print(email);
    try {
      UserCredential data =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: "Vetcare@123",
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: data.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${email.toString()}',
          lastName: "",
        ),
      );
      updateFid(data.user!.uid);
    } catch (e) {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(),
        password: "Vetcare@123",
      );
      // App.localStorage.setString("firebaseUid", credential.user!.uid);
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: name.toString(),
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=${email.toString()}',
          lastName: "",
        ),
      );
      updateFid(credential.user!.uid);
      print(e.toString());
    }
  }


}
