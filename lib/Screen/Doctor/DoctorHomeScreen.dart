import 'dart:convert';

import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Screen/Doctor/AnimalDetailScreen.dart';
import 'package:eshopmultivendor/Screen/Authentication/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  bool isLoading = false ;

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

          getRequest();


        },



        tabs: [
          Tab(
            child: SizedBox(width: MediaQuery.of(context).size.width/3,child: Center(child: Text('Latest')),),
        ),
          Tab(
              child: SizedBox(width: MediaQuery.of(context).size.width/3,child: Center(child: Text('Accepted')),)
          ),],
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    getProfile();
    getRequest();
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
      body:isLoading ? Center(child: CircularProgressIndicator(),) :  TabBarView(
        physics: NeverScrollableScrollPhysics(),

        controller: tabController,
      children: [
        SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: latestList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = latestList[index];
            return InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetailScreen(animalDetail: item),));
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
                                "Pet Owner",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.username ?? ''),
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
                                "Email",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.email ?? ''),
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
                                "Owner Contact:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.mobile ?? ''),
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
                                "Breeds ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.breed ?? ''),
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
                                "Disease",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(item.disease ?? ''),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  acceptRejectRequest(item.id ?? '', '1');
                                },
                                child: Container(
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
                              ),
                              InkWell(
                                onTap: (){
                                  acceptRejectRequest(item.id ?? '', '2');
                                },
                                child: Container(
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
      ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: acceptedList.length,
            itemBuilder: (BuildContext context, int index) {
              var item = acceptedList[index];
              return InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalDetailScreen(animalDetail: item),));
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
                                  "Pet Owner",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(item.username ?? ''),
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
                                  "Email",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(item.email ?? ''),
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
                                  "Owner Contact:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(item.mobile ?? ''),
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
                                  "Breeds ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(item.breed ?? ''),
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
                                  "Disease",
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
                                  "Status",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Accepted'),
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
        ),
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
              // _getDrawerItem(3, getTranslated(context, "WALLETHISTORY")!,
              //     Icons.account_balance_wallet_outlined),
              // _getDrawerItem(11, "Daily Collection", Icons.account_balance_wallet_outlined),
              // _getDrawerItem(12, "Transaction",
              //     Icons.compare_arrows_sharp),
              // Divider(),
              // _getDrawerItem(4, getTranslated(context, "PRODUCTS")!,
              //     Icons.production_quantity_limits_outlined),
              // _getDrawerItem(10, "Add Product", Icons.add),
              // Divider(),
              // _getDrawerItem(5, getTranslated(context, "ChangeLanguage")!,
              //     Icons.translate),
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
                builder: (context) => ProductList(
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
          } else if (title == "Add Product") {
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
          }
        },
      ),
    );
  }

//  => Drawer Header

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
                    style: Theme.of(context)
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
                          style: Theme.of(context)
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
                style: Theme.of(this.context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: fontColor),
              ),
              actions: <Widget>[
                new TextButton(
                    child: Text(
                      getTranslated(context, "LOGOUTNO")!,
                      style: Theme.of(this.context)
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
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
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

    var parameter = {Id: CUR_USERID};
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
              degreeName ?? '');
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

Future<void> getRequest()async{
  isLoading =  true;
  setState(() {

  });

  CUR_USERID = await getPrefrence(UserId);

  var perameter = {UserId: CUR_USERID};

    apiBaseHelper.doctorPostAPICall(getPatientRequests, perameter).then(
            (getData) async{

      bool error = getData["error"];
      String? msg = getData["message"];

      if (!error) {

        acceptedList=   PatientRequstResonse.fromJson(jsonDecode(jsonEncode(getData))).data?.accepted ?? [];
        latestList=   PatientRequstResonse.fromJson(jsonDecode(jsonEncode(getData))).data?.latest ?? [];
        print("_______${acceptedList.first.disease}_______");

       setState(() {
isLoading =  false ;
       });

      }

    });

}

  Future<void> acceptRejectRequest(String id, String status) async{
    CUR_USERID = await getPrefrence(UserId);

    var parameter = {
      UserId: CUR_USERID,
      Id: id,
      Status:status

    };
    apiBaseHelper.doctorPostAPICall(getAcceptRejectRequests, parameter).then((getData) {

      setDoctorSnackbar(getData["message"], context);

    });


  }
}
