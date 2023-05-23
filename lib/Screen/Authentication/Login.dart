import 'dart:async';
import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/ContainerDesing.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Helper/app_assets.dart';
import 'package:eshopmultivendor/Screen/Authentication/registration.dart';
import 'package:eshopmultivendor/Screen/TermFeed/Privacy_Policy.dart';
import 'package:eshopmultivendor/Screen/TermFeed/Terms_Conditions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../Doctor/DoctorHomeScreen.dart';
import '../Home.dart';
import 'SendOtp.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
//==============================================================================
//============================= Variables Declaration ==========================

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode? passFocus, monoFocus = FocusNode();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final mobileController = TextEditingController();
  String? password,
      mobile,
      username,
      email,
      id,
      balance,
      image,
      address,
      registeration_no,
      degreeName,
      registerationCard,
      fcm_id,
      idCard,
      degree,
      certificate,
      accNo,
      accname,
      bankCode,
      bankName,
      latitutute,
      longitude,
      cheque,
      tax_number,
      pan_number,
      status,
      signature ;
  bool _isNetworkAvail = true;
  var fcmToken = "";

//==============================================================================
//============================= INIT Method ====================================

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    super.initState();
    geFcmToken();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      new CurvedAnimation(
        parent: buttonController!,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
    setState(() {
      mobileController.text = "";
      passwordController.text = "";
    });
  }

  geFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      fcmToken = token!;
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>$fcmToken");
    });
  }

//==============================================================================
//============================= For Animation ==================================

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

//==============================================================================
//============================= Network Checking ===============================

  Future<void> checkNetwork() async {
    _isNetworkAvail = await isNetworkAvailable();
    if (_isNetworkAvail) {
      getLoginUser();
    } else {
      Future.delayed(Duration(seconds: 1)).then(
        (_) async {
          await buttonController!.reverse();
          setState(
            () {
              _isNetworkAvail =false;
            },
          );
        },
      );
    }
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

//==============================================================================
//============================= Dispose Method =================================

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    //   systemNavigationBarColor: Colors.transparent,
    // ));
    buttonController!.dispose();
    super.dispose();
  }

  // setSnackbar(String msg) {
  //   ScaffoldMessenger.of(context)!.showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         msg,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: fontColor,
  //         ),
  //       ),
  //       duration: Duration(
  //         milliseconds: 3000,
  //       ),
  //       backgroundColor: lightWhite,
  //       elevation: 1.0,
  //     ),
  //   );
  // }

//==============================================================================
//============================= No Internet Widget =============================

  Widget noInternet(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            noIntImage(),
            noIntText(context),
            noIntDec(context),
            AppBtn(
              title: getTranslated(context, 'TRY_AGAIN_INT_LBL'),
              btnAnim: buttonSqueezeanimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _playAnimation();

                Future.delayed(Duration(seconds: 2)).then(
                  (_) async {
                    _isNetworkAvail = await isNetworkAvailable();
                    if (_isNetworkAvail) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget),
                      );
                    } else {
                      await buttonController!.reverse();
                      setState(
                        () {},
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

//==============================================================================
//============================= LOGIN API ======================================

  Future<void> getLoginUser() async {
    var data = {
      Mobile: mobile,
      Password: password,
      //"fcm_id": "$fcmToken",
    };

    apiBaseHelper.doctorPostAPICall(getDoctorLogin, data).then(
      (getdata) async {
        bool error = getdata["error"];

        String? msg = getdata["message"];
        print(getDoctorLogin);
        // if (!error) {
          //setSnackbar(msg!);
        if(!(error)) {
          var data = getdata["data"][0];
          id = data[Id];
          username = data[Username];
          email = data[Email];
          mobile = data[Mobile];
          address = data[Address];
          image = data[IMage];
          registeration_no = data[RegistrationNo];
          CUR_USERID = id!;
          CUR_USERNAME = username!;
          //CUR_BALANCE = balance!;
          idCard = data[IdCard] ?? "";
          degree = data[DegreeFile] ?? "";
          certificate = data[Certificate] ?? "";
          accNo = data[accountNumber] ?? "";
          accname = data[accountName] ?? "";
          bankCode = data[BankCOde] ?? "";
          bankName = data[bankNAme] ?? "";
          // latitutute = data[Latitude] ?? "";
          //longitude = data[Longitude] ?? "";
          cheque = data[Cheque] ?? "";
          //tax_number = data[taxNumber] ?? "";
          //pan_number = data[panNumber] ?? "";
          //status = data[STATUS] ?? "";
          signature = data[Signature] ?? "";
          degreeName = data[DegreeName] ?? "";


          saveUserDetail(
              id!,
              username!,
              email!,
              mobile!,
              address!,
              idCard!,
              degree!,
              certificate!,
              accNo!,
              accname!,
              bankCode ?? "",
              bankName ?? "",
              latitutute ?? "",
              longitude ?? "",
              cheque ?? "",
              tax_number ?? "",
              pan_number ?? "",
              status ?? '',
              signature ?? '',
              registeration_no ?? '',
              degreeName ?? ''
          );
          setPrefrenceBool(isLogin, true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorHomeScreen(),
            ),
          );
        } else {
         setSnackbar(msg ?? '');

          await buttonController!.reverse();

          setState(() {});
        }
      },
      onError: (error) {
        setSnackbar(error.toString());
      },
    );
  }

//==============================================================================
//============================= Term And Policy ================================

  termAndPolicyTxt() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 30.0,
        left: 25.0,
        right: 25.0,
        top: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            getTranslated(context, "CONTINUE_AGREE_LBL")!,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: fontColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Terms_And_Condition(),
                      ),
                    );
                  },
                  child: Text(
                    getTranslated(context, 'TERMS_SERVICE_LBL')!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal),
                  )),
              SizedBox(
                width: 5.0,
              ),
              Text(
                getTranslated(context, "AND_LBL")!,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: fontColor, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ),
                  );
                },
                child: Text(
                  getTranslated(context, "PRIVACYPOLICY")!,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldKey,
        body: _isNetworkAvail
            ? Stack(
                children: [
                  Container(
                    // color: primary,
                    width: double.infinity,
                    height: double.infinity,
                    decoration: back(),
                  ),
                  Image.asset(
                    'assets/images/doodle.png',
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  getLoginContainer(),
                  getLogo(),
                ],
              )
            : noInternet(context),
      ),
    );
  }

//==============================================================================
//============================= Login Container widget =========================

  getLoginContainer() {
    return Positioned.directional(
      start: MediaQuery.of(context).size.width * 0.025,
      top: MediaQuery.of(context).size.height * 0.2,
      textDirection: Directionality.of(context),
      child: ClipPath(
        clipper: ContainerClipper(),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * 0.8,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.95,
          color: white,
          child: Form(
            key: _formkey,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 2,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      setSignInLabel(),
                      setMobileNo(),
                      setPass(),
                      loginBtn(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have An Account?"),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));

                            },
                              child: Text("SignUp",style: TextStyle(color: primary,fontSize: 17),)),
                        ],
                      ),
                      termAndPolicyTxt(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget setSignInLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          getTranslated(context, 'Login In')!,
          style: const TextStyle(
            color: primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  setMobileNo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.only(
        top: 30.0,
      ),
      child: TextFormField(
        maxLength: 10,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(passFocus);
        },
        keyboardType: TextInputType.number,
        controller: mobileController,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        focusNode: monoFocus,
        textInputAction: TextInputAction.next,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (val) => validateMob(val!, context),
        onSaved: (String? value) {
          mobile = value;
        },
        decoration: InputDecoration(
          counterText: "",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(7.0),
          ),
          prefixIcon: Icon(
            Icons.phone_android,
            color: lightBlack2,
            size: 20,
          ),
          hintText: getTranslated(context, "Mobile Number")!,
          hintStyle: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                color: lightBlack2,
                fontWeight: FontWeight.normal,
              ),
          filled: true,
          fillColor: white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40,
            maxHeight: 20,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightBlack2),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }

  setPass() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.only(
        top: 15.0,
      ),
      child: TextFormField(
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(passFocus);
        },
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
        style: TextStyle(
          color: fontColor,
          fontWeight: FontWeight.normal,
        ),
        focusNode: passFocus,
        textInputAction: TextInputAction.next,
        validator: (val) => validatePass(val!, context),
        onSaved: (String? value) {
          password = value;
        },
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.circular(7.0),
          ),
          prefixIcon: SvgPicture.asset(
            "assets/images/password.svg",
          ),
          suffixIcon: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SendOtp(
                    title: getTranslated(context, "FORGOT_PASS_TITLE")!,
                  ),
                ),
              );
            },
            child: Text(
              getTranslated(context, "FORGOT_PASSWORD_LBL")!,
              style: TextStyle(
                color: primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          hintText: getTranslated(context, "PASSHINT_LBL"),
          hintStyle: Theme.of(this.context)
              .textTheme
              .subtitle2!
              .copyWith(color: lightBlack2, fontWeight: FontWeight.normal),
          fillColor: white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          suffixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
          prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightBlack2),
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
      ),
    );
  }

  loginBtn() {
    return AppBtn(
      title: getTranslated(context, "SIGNIN_LBL")!,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        validateAndSubmit();

        //
      },
    );
  }

  Widget getLogo() {
    return Positioned(
      left: (MediaQuery.of(context).size.width / 2) - 50,
      top: (MediaQuery.of(context).size.height * 0.2) - 50,
      child: SizedBox(
        width: 100,
        height: 100,
        // child: SvgPicture.asset(
        //   'assets/images/loginlogo.svg',
        // ),
        child: Image.asset(Myassets.login_logo),
      ),
    );
  }

  setSnackbar(String msg) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content:  Text(
        msg ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(color: primary),
      ),
      backgroundColor: white,
      elevation: 1.0,
    ));
  }
}
