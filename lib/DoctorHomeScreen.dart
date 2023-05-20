import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Screen/Authentication/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Session.dart';
import 'Helper/String.dart';
import 'Screen/Add_Product.dart';
import 'Screen/Customers.dart';
import 'Screen/OrderList.dart';
import 'Screen/ProductList.dart';
import 'Screen/Profile.dart';

import 'Screen/WalletHistory.dart';
import 'Screen/contactusnew.dart';
import 'Screen/daily_collection.dart';
import 'Screen/privacynew.dart';
import 'Screen/tncnew.dart';
import 'Screen/transaction.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int curDrwSel = 0;
  //==============================================================================
//============================ AppBar ==========================================

  getAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset("assets/logo/food_on_the_way.png",height: 70,),
      backgroundColor: white,
      iconTheme: IconThemeData(color: grad2Color),
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
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) { return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: white,
                elevation: 2,child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("19/4/2023"),
                        ],
                      ),
                    ),

                    Padding(

                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),

                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Pet Name",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Monty"),
                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),

                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Owner Contact:",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("9898989898"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),

                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Breeds ",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("German"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Disease",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Canine distemper"),
                        ],
                      ),
                    ),
                    Padding(
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
                              child:Center(child:Text("Accept",style: TextStyle(color: white),) ,) ),
                          Container(
                            height: 35,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                                color: Colors.red),
                              child: Center(child: Text("Reject",style: TextStyle(color: white),))),
                        ],
                      ),
                    ),
                  ],
                ),),
            ),
          );},

        ),
      ),
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
          }
          else if (title == getTranslated(context, "ORDERS")!) {
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
          }
          else if (title == getTranslated(context, "CUSTOMERS")!) {
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
          }
          else if (title == getTranslated(context, "WALLETHISTORY")!) {
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
          }
          else if (title == "Daily Collection") {
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
          }
          else if (title == "Transaction") {
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
          }
          else if (title == getTranslated(context, "PRODUCTS")!) {
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
          }
          else if (title == getTranslated(context, "ChangeLanguage")!) {
            setState(
                  () {
                curDrwSel = index;
              },
            );
            // languageDialog();
          }
          else if (title == getTranslated(context, "T_AND_C")!) {
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
          }
          else if (title == getTranslated(context, "CONTACTUS")!) {
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
          }
          else if (title == getTranslated(context, "PRIVACYPOLICY")!) {
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
          }
          else if (title == getTranslated(context, "LOGOUT")!) {
            Navigator.pop(context);
            logOutDailog();
          }
          else if (title == "Add Product") {
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
}
