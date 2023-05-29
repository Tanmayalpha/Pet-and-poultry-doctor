import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/DoctorDegreeResponse.dart';
import 'package:eshopmultivendor/Screen/Authentication/Login.dart';
import 'package:eshopmultivendor/Screen/Doctor/DoctorHomeScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import 'package:http/http.dart' as http;
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../Helper/Color.dart';
import '../../Helper/appbutton.dart';
import '../../Model/Doctordegreemodel.dart';
import '../Home.dart';

class RegistrationScreen extends StatefulWidget {
  final int? role ;
  String? id;


  RegistrationScreen({Key? key, this.role,this.id}) : super(key: key);


  @override
  State<RegistrationScreen> createState() => _DoctorResignationState();
}

class _DoctorResignationState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phonelController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController CpassController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController registrationCardController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();


  List<DoctorList> doctorList = [];


  bool isDoctor = false;
  File? idImage;
  File? degree;
  File? registrationCard;
  File? profileImage;
  File? certificate;
  File? cheque;
  File? signature;
  DateTime? date ;

  Degree? selectedDegree;
  Degree? selectedSpecialization;


  String? categoryValue;
  String? categoryValue2;

  int _value = 1;
  int _accountTypeValue = 1;

  bool isLoading = false;
  String  gender =  "Male";


  String finalString ='';

  int category = 2;
  List results = [];



  final ImagePicker _picker = ImagePicker();







  // RegistrationModel? detailsData;


  // registration() async {
  //   if(imageFile ==null ){
  //     Fluttertoast.showToast(msg: 'Please add registration card');
  //   }else if(imageFile1 == null){
  //     Fluttertoast.showToast(msg: 'Please add profile photo');
  //   }else {
  //     String? token;
  //     try {
  //       token = await FirebaseMessaging.instance.getToken();
  //       print("-----------token:-----${token}");
  //     } on FirebaseException {
  //       print('__________FirebaseException_____________');
  //     }
  //
  //     if (widget.role == 2 && finalString.isEmpty) {
  //       Fluttertoast.showToast(msg: 'Please select category');
  //     } else {
  //       print("this is user registration ");
  //       var headers = {
  //         'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
  //       };
  //       var request = http.MultipartRequest(
  //           'POST', Uri.parse('${ApiService.userRegister}'));
  //       request.fields.addAll({
  //         'email': emailController.text,
  //         'mobile': mobileController.text,
  //         'username': nameController.text,
  //         'gender': gender.toString(),
  //         'doc_degree': docdegreeController.text,
  //         'address': addressController.text,
  //         'c_address': clinikaddressController.text,
  //         'cat_type': SelectedPharma.toString(),
  //         'category_id': finalString.isEmpty && widget.id != null
  //             ? widget.id ?? ''
  //             : finalString,
  //         'password': passController.text,
  //         'roll': widget.role.toString(),
  //         'confirm_password': CpassController.text,
  //         'fcm_id': token ?? ''
  //       });
  //       print("Surendra------------>${ApiService.userRegister}");
  //
  //       if (imageFile != null) {
  //         request.files.add(await http.MultipartFile.fromPath(
  //             'registration_card', imageFile?.path ?? ''));
  //       }
  //       if (imageFile1 != null) {
  //         request.files.add(await http.MultipartFile.fromPath(
  //             'image', imageFile1?.path ?? ''));
  //       }
  //
  //       print(
  //           "this is request ===>>>>surendra ${request.fields}   ${request.files.toString()}");
  //       request.headers.addAll(headers);
  //       http.StreamedResponse response = await request.send();
  //
  //       if (response.statusCode == 200) {
  //         if (!(detailsData?.user ?? false)) {
  //           Fluttertoast.showToast(msg: "User Registered Successfully!!");
  //           Navigator.pushReplacement(context,
  //               MaterialPageRoute(builder: (context) => LoginScreen()));
  //         }
  //         setState(() {
  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         print(response.reasonPhrase);
  //       }
  //     }
  //   }
  // }
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  DoctorDegreeResponse ? _doctorDegreeResponse;

  List<Degree> degreesList = [];
  List<Degree> specializationList = [];
  bool _isNetworkAvail = true;


    void initState() {
    // TODO: implement initState
    super.initState();
    getSpecializationAndDegree();
    geFcmToken();

  }

  void _showMultiSelect(int category) async {
    results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Text("");
        });
      },
    );
    setState(() {});
  }
  bool _isObscure = true;
  bool _isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: customAppBar(
        //     text:
        //     "${widget.role == 1 ? "Doctor" : "Pharma(PMT Team & Marketing)"}",
        //     isTrue: true,
        //     context: context),
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon:Icon(Icons.arrow_back), color: white,),
        backgroundColor: primary,
      centerTitle: true,
      title: Text(" Doctor Registration",style: TextStyle(color: white),),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileWidget(),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, color: secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name is required";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Mobile No",
                            style: TextStyle(
                               fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                 fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        counterText: "",
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.length != 10) {
                        return "mobile number is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "Email Id",
                            style: TextStyle(
                               fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),

                        ],
                      )

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle: const TextStyle(
                            fontSize: 15.0, ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Email is required";
                      }
                      if (!v.contains("@")) {
                        return "Enter Valid Email Id";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Select Doctor Type",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) =>  secondary),
                            activeColor: secondary,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                gender = "Junior Dr.";
                                //isMobile = false;
                              });
                            },
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Senior Doctor",
                            style: TextStyle(
                                 fontSize: 15),
                          ),
                          SizedBox(height: 5,),
                          Radio(
                              value: 2,
                              fillColor: MaterialStateColor.resolveWith(
                                      (states) => secondary),
                              activeColor:  secondary,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  gender = "Female";
                                  // isMobile = true;
                                });
                              }),
                          // SizedBox(width: 10.0,),
                          Text(
                            "Junior Doctor",
                            style: TextStyle(
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),*/
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Select Doctor Degree",
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      ),*/
                      /*SizedBox(height: 5,),*/
                      /*Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            // Initial Value
                            value: categoryValue,
                            // underline: Container(),
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: Icon(Icons.keyboard_arrow_down, color: primary,),
                            hint: Text("Select Doctor Degree", style: TextStyle(
                                color: Colors.black
                            ),),
                            // Array list of items
                            items: doctorList.map((items) {
                              return DropdownMenuItem(
                                value: items.id,
                                child: Container(
                                    child: Text(items.name.toString())),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                categoryValue = newValue!;
                                print("selected category ${categoryValue}");
                              });
                            },
                          ),

                        ),
                      ),*/
                      doctorDegree('Select Doctor Degree', degreesList),
                      SizedBox(height: 15,),
                      doctorSpecification('Select Doctor Specialization', specializationList),
                      const SizedBox(height: 10,),
                      // Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Row(
                      //       children: [
                      //         Text(
                      //           "Category",
                      //           style: TextStyle(
                      //             // color: colors.black54,
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //         Text(
                      //           "*",
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold,fontSize: 10),
                      //         ),
                      //       ],
                      //     )
                      //
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // select(),
                    ],
                  ) ,
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Password",
                          style: TextStyle(
                               fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3,left: 2),
                          child: Text(
                            "*",
                            style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: _isObscurePassword,
                    controller: passController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration().getTextFieldDecoration(),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "password is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            "Confirm password",
                            style: TextStyle(
                                 fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    controller: CpassController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure ? Icons.visibility : Icons.visibility_off,color: secondary,),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })
                    ),
                    validator: (v) {
                      if (v!.isEmpty || CpassController.text != passController.text) {
                        return "password does not match";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(
                                 fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                               fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onTap: (){
                      _getLocation();
                    },
                    controller: addressController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Address is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Registration No.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: registrationCardController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        hintStyle:
                        TextStyle(fontSize: 15.0, color: secondary),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10, top: 10)),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "registration No. required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:Row(
                        children: [
                          Text(
                            "Valid Up To",
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 10),
                          ),
                        ],
                      )


                  ),
                  SizedBox(
                    height: 10,
                  ),
                  validUpTo(),
                  imageTitleText('Registration Card'),
                  const SizedBox(
                    height: 10,
                  ),
                  imageUploadWidget(registrationCard, 'registration'),
                  const SizedBox(height: 20,),
                  imageTitleText('Doctor Id Card'),
                  const SizedBox(
                    height: 10,
                  ),
                  imageUploadWidget(idImage, 'id'),
                  const SizedBox(height: 20,),
                  imageTitleText('Degree'),
                  const SizedBox(
                    height: 10,
                  ),
                  imageUploadWidget(degree, 'degree'),
                  const SizedBox(height: 20,),
                  imageTitleText('Certificate'),
                  const SizedBox(
                    height: 10,
                  ),
                  imageUploadWidget(certificate, 'certificate'),
                  const SizedBox(height: 20,),
                  imageTitleText('Account Detail'),
                  accountDetailWidget(),
                  const SizedBox(
                    height: 45,
                  ),
                  Center(
                    child: Btn(
                        height: 50,
                        width: 320,
                        title: isLoading == true ? "Please wait......" : 'Submit',
                        color: secondary,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            registerDocter();
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            const snackBar = SnackBar(
                              content: Text('All Fields are required!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget select() {
    return InkWell(
      onTap: () {
        _showMultiSelect(category);
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black.withOpacity(0.7))),
          child: results.isEmpty
              ? const Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
            child: Text(
              'Select Categories',
              style: TextStyle(
                fontSize: 16,

                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          )
              : Wrap(
            children: results.map((item) {
              String itemId = item.id.toString();
              finalString = '${finalString},${itemId}';
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Chip(
                  backgroundColor:primary,
                  label: Text(
                    "${item.name}",
                    style: TextStyle(color: Colors.white),
                    //item.name
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Widget profileWidget(){
    return  InkWell(
      onTap: (){
        showPopupForImage('profile');
      },
      child: Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Stack(children: [
            profileImage == null ? CircleAvatar(radius: 50,backgroundImage: AssetImage(''))
              :CircleAvatar(radius: 50,backgroundImage: FileImage(profileImage ?? File('')),
            ),
            Positioned(

                right: 10,
                bottom: 10,

                child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit)))
          ],),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "*",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 10),
                ),
              ],
            )),
      ],),
    );
  }

  Widget doctorDegree(String titleText, List <Degree> list, ){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          titleText,
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 5,),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Degree>(
            // Initial Value
            value: selectedDegree,
            // underline: Container(),
            isExpanded: true,
            // Down Arrow Icon
            icon: Icon(Icons.keyboard_arrow_down, color: primary,),
            hint: Text(titleText, style: TextStyle(
                color: Colors.black
            ),),
            // Array list of items
            items: list.map((Degree items) {
              return DropdownMenuItem<Degree>(
                value: items,
                child: Container(
                    child: Text(items.name.toString())),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (Degree? newValue) {
              setState(() {
                selectedDegree = newValue;
                print("selected category ${categoryValue}");
              });
            },
          ),
          // DropdownButton(
          //   hint: const Text("Select Dr. Degree", style: TextStyle(color: Colors.black54),),
          //   isExpanded: true,
          //   elevation: 0,
          //   value: SelectedPharma,
          //   icon: const Icon(
          //     Icons.keyboard_arrow_down,
          //     size: 40,
          //     color:primary,
          //   ),
          //   items: items.map((String items) {
          //     return DropdownMenuItem(
          //         value: items,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(
          //             items,
          //             style: TextStyle(color:primary),
          //           ),
          //         ));
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       SelectedPharma = newValue!;
          //       selectedIndex = items.indexOf(newValue);
          //       if (selectedIndex == 0) {
          //         category = 2;
          //       } else {
          //         category = 3;
          //       }
          //       /*selectedIndex++;
          // print("tttttt--------->${selectedIndex}");*/
          //     });
          //   },
          // ),
        ),
      ),
    ],);
  }
  Widget doctorSpecification(String titleText, List <Degree> list, ){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            titleText,
            style: TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black54)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Degree>(
              // Initial Value
              value: selectedSpecialization,
              // underline: Container(),
              isExpanded: true,
              // Down Arrow Icon
              icon: Icon(Icons.keyboard_arrow_down, color: primary,),
              hint: Text(titleText, style: TextStyle(
                  color: Colors.black
              ),),
              // Array list of items
              items: list.map((Degree items) {
                return DropdownMenuItem<Degree>(
                  value: items,
                  child: Container(
                      child: Text(items.name.toString())),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (Degree? newValue) {
                setState(() {
                  selectedSpecialization = newValue;
                  print("selected category ${categoryValue}");
                });
              },
            ),
            // DropdownButton(
            //   hint: const Text("Select Dr. Degree", style: TextStyle(color: Colors.black54),),
            //   isExpanded: true,
            //   elevation: 0,
            //   value: SelectedPharma,
            //   icon: const Icon(
            //     Icons.keyboard_arrow_down,
            //     size: 40,
            //     color:primary,
            //   ),
            //   items: items.map((String items) {
            //     return DropdownMenuItem(
            //         value: items,
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             items,
            //             style: TextStyle(color:primary),
            //           ),
            //         ));
            //   }).toList(),
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       SelectedPharma = newValue!;
            //       selectedIndex = items.indexOf(newValue);
            //       if (selectedIndex == 0) {
            //         category = 2;
            //       } else {
            //         category = 3;
            //       }
            //       /*selectedIndex++;
            // print("tttttt--------->${selectedIndex}");*/
            //     });
            //   },
            // ),
          ),
        ),
      ],);
  }

  Widget imageTitleText(String titleText){
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children:  [
            Text(
              titleText,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "*",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
          ],
        )

    );
  }

  Widget imageUploadWidget(File? image, String from){
    return InkWell(
      onTap: () {
        showPopupForImage(from);
      },
      child: Container(
        height: image == null ? 50:155,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          dashPattern: [5, 5],
          color: Colors.grey,
          strokeWidth: 2,
          child: image == null || image == ""
              ? Center(
              child: Icon(
                Icons.drive_folder_upload_outlined,
                color: Colors.grey,
                size: 30,
              ))
              : Column(
            children: [
              Image.file(
                image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountDetailWidget (){
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Column(children: [
          TextFormField(
            controller: accountNoController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration().getTextFieldDecoration(label: 'Account No.'),
            validator: (v) {
              if (v!.isEmpty) {
                return "account Num is required";
              }
            },
          ),
          const SizedBox(height: 10,),
          imageTitleText('Account Type'),
          Row(
            children: [
              Radio(
                value: 1,
                fillColor: MaterialStateColor.resolveWith(
                        (states) =>  secondary),
                activeColor: secondary,
                groupValue: _accountTypeValue,
                onChanged: (int? value) {
                  setState(() {
                    _accountTypeValue = value!;

                    //isMobile = false;
                  });
                },
              ),
              SizedBox(height: 10,),
              Text(
                "Saving",
                style: TextStyle(
                    fontSize: 15),
              ),
              SizedBox(height: 5,),
              Radio(
                  value: 2,
                  fillColor: MaterialStateColor.resolveWith(
                          (states) => secondary),
                  activeColor:  secondary,
                  groupValue: _accountTypeValue,
                  onChanged: (int? value) {
                    setState(() {
                      _accountTypeValue = value!;
                      gender = "Female";
                      // isMobile = true;
                    });
                  }),
              // SizedBox(width: 10.0,),
              Text(
                "Current",
                style: TextStyle(
                    fontSize: 15),
              ),
            ],
          ),
          TextFormField(
            controller: accountNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration().getTextFieldDecoration(label: 'Account Name'),
            validator: (v) {
              if (v!.isEmpty) {
                return "account Name is required";
              }
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: ifscController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration().getTextFieldDecoration(label: 'IFSC'),
            validator: (v) {
              if (v!.isEmpty) {
                return "ifsc is required";
              }
            },
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: bankNameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration().getTextFieldDecoration(label: 'Bank Name'),
            validator: (v) {
              if (v!.isEmpty) {
                return "Bank name is required";
              }
            },
          ),
          const SizedBox(height: 10,),
          imageTitleText('Upload Cancel Cheque'),
          const SizedBox(height: 10,),
          imageUploadWidget(cheque, 'cheque'),
          const SizedBox(height: 10,),
          imageTitleText('Upload Signature'),
          const SizedBox(height: 10,),
          imageUploadWidget(signature, 'signature'),
          const SizedBox(height: 10,)


        ],),
      ),

    );
  }

  Widget validUpTo(){
    return InkWell(
      onTap: ()async{
        DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025),
            //firstDate: DateTime.now().subtract(Duration(days: 1)),
            // lastDate: new DateTime(2022),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                    primaryColor: primary,
                    accentColor: Colors.black,
                    colorScheme: ColorScheme.light(primary: primary),
                    // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                    buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
                child: child!,
              );
            });
        if(picked!= null) {
            date = picked ;
            setState(() {

            });
        }
      }, child: Container(
      padding: EdgeInsets.all(10),
      height: 40,width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: primary),
      child: date== null ? Text('Select Date', style: TextStyle(color: Colors.white),): Text(date.toString().substring(0,10),style: TextStyle(color: Colors.white)),));


  }



  Future<void> registerDocter() async{
    _isNetworkAvail = await isNetworkAvailable();

    isLoading = true;
    setState(() {

    });

    if(profileImage == null) {
      setDoctorSnackbar('Please add ProfileImage', context);
    }
    else if(date == null){setDoctorSnackbar('Please add date', context);}
    else if(registrationCard == null){setDoctorSnackbar('Please add registrationCard', context);}
    else if(idImage == null){setDoctorSnackbar('Please add Id', context);}
    else if(degree == null){setDoctorSnackbar('Please add Degree', context);}
    else if(certificate == null){setDoctorSnackbar('Please add Certificate', context);}
    else if(cheque == null){setDoctorSnackbar('Please add cheque', context);}
    else if(signature == null){setDoctorSnackbar('Please add signature', context);}
    else if(selectedDegree == null){setDoctorSnackbar('Please select degree', context);}
    else if(selectedSpecialization == null){setDoctorSnackbar('Please select specialization', context);}
    else {
      var request = http.MultipartRequest('POST', getDoctorRegistration);
      request.fields.addAll({
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
        'specialist': selectedSpecialization?.id ?? '',
        'degree': selectedDegree?.id ?? '',
        'password': passController.text,
        'confirm_password': CpassController.text,
        'address': addressController.text,
        'registeration_no': registrationCardController.text,
        'valid_registeration_date': date.toString().substring(0, 10),
        'account_number': accountNoController.text,
        'account_type': 'Saving',
        'account_holder_name': accountNameController.text,
        'bank_name': bankNameController.text,
        'ifsc_code': ifscController.text,
        'branch_name': 'canra',
        'upi_id': '',
        'fcm_id': fcmToken ?? '',
        'latitude': lat ?? '',
        'longitude': long ?? ''
      });
      request.files.add(await http.MultipartFile.fromPath(
          'registeration_card_file', registrationCard?.path ?? ''));
      request.files.add(await http.MultipartFile.fromPath(
          'id_card_file', idImage?.path ?? ''));
      request.files.add(
          await http.MultipartFile.fromPath('degree_file', degree?.path ?? ''));
      request.files.add(await http.MultipartFile.fromPath(
          'certificate_file', certificate?.path ?? ''));
      request.files.add(await http.MultipartFile.fromPath(
          'cancel_cheque', cheque?.path ?? ''));
      request.files.add(await http.MultipartFile.fromPath(
          'signature', signature?.path ?? ''));
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', profileImage?.path ?? ''));
      request.headers.addAll(doctorHeader);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var finalResult = jsonDecode(result);
        isLoading = false;
        setState(() {});
        if(!(finalResult['error'])){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
          setDoctorSnackbar(finalResult['message'], context);

        }else{
          setDoctorSnackbar(finalResult['message'], context);
        }
      } else {
        print(response.reasonPhrase);
        setDoctorSnackbar('Something went wrong', context);
        isLoading = false;
        setState(() {

        });
      }
    }
  }


Future<void> getSpecializationAndDegree() async{

  _isNetworkAvail = await isNetworkAvailable();


  apiBaseHelper.doctorGetAPICall(getDoctorSpecialization).then(
        (getdata) async {
      bool error = getdata["error"];
      String? msg = getdata["message"];
      if (!error) {
        _doctorDegreeResponse = DoctorDegreeResponse.fromJson(getdata);
        print("_______${_doctorDegreeResponse?.data?.degrees?.first.name}_______");
        degreesList = _doctorDegreeResponse?.data?.degrees ?? [];
        specializationList = _doctorDegreeResponse?.data?.specialization ?? [];

       setDoctorSnackbar(msg!,context);
        setState(() {});
      } else {
       // await buttonController!.reverse();
       // setSnackbar(msg!);
        setState(() {});
      }
    },
    onError: (error) {
      setDoctorSnackbar(error.toString(),context);
    },
  );


}

  Future<bool> showPopupForImage(String from) async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromCamera(from);
                },
                //return false when click on "NO"
                child: Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery(from);
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  _getFromGallery(String from) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100,maxHeight: 480, maxWidth: 480);
    /* PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );*/
    if (pickedFile != null) {

      setState(() {
        if(from == 'profile'){
          profileImage = File(pickedFile.path);
        }else if(from == 'id'){
          idImage = File(pickedFile.path);
        }else if(from == 'degree'){
          degree = File(pickedFile.path);
        }else if(from == 'certificate'){
          certificate = File(pickedFile.path);
        }else if(from == 'cheque'){
          cheque = File(pickedFile.path);
        }else if(from == 'signature'){
          signature = File(pickedFile.path);
        }else{
          registrationCard = File(pickedFile.path);
        }
        //imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  _getFromCamera(String from) async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100, maxHeight: 480, maxWidth: 480);
    /*  PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );*/
    if (pickedFile != null) {
      setState(() {
        if(from == 'profile'){
          profileImage = File(pickedFile.path);
        }else if(from == 'id'){
          idImage = File(pickedFile.path);
        }else if(from == 'degree'){
          degree = File(pickedFile.path);
        }else if(from == 'certificate'){
          certificate = File(pickedFile.path);
        }else if(from == 'cheque'){
          cheque = File(pickedFile.path);
        }else if(from == 'signature'){
          signature = File(pickedFile.path);
        }else{
          registrationCard = File(pickedFile.path);
        }

      });
      Navigator.pop(context);
    }
  }

 String? lat;
  String?long;
  String? fcmToken ;

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
          "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
        )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      addressController.text = result.formattedAddress.toString();
      lat = result.latLng!.latitude.toString();
      long = result.latLng!.longitude.toString();
    });
  }

  geFcmToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      fcmToken = token!;
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>$fcmToken");
    });
  }


}

extension on InputDecoration {
  InputDecoration getTextFieldDecoration ({String? label}) {
    return InputDecoration(
      label: Text(label ?? ''),
        hintText: '',
        hintStyle:
        TextStyle(fontSize: 15.0, color: secondary),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        contentPadding: EdgeInsets.only(left: 10, top: 10),

    );
  }
}

/*extension on InputDecoration {
  InputDecoration getTextFieldDeco(String hint, double maxWidth, String prefix,
      {bool? isGreenAlpha}) {
    return InputDecoration(
      fillColor:
          (isGreenAlpha ?? false) ? greenColor.withOpacity(0.4) : greenColor,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      hintStyle: const TextStyle(color: secondaryColor),
      prefixIconConstraints: BoxConstraints(minWidth: 0, maxWidth: maxWidth),
      prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerLeft,
          child: Text(prefix,
              style: const TextStyle(
                color: secondaryColor,
                fontSize: 16,
              ))),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: (isGreenAlpha ?? false)
              ? greenColor.withOpacity(0.4)
              : greenColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: (isGreenAlpha ?? false)
              ? greenColor.withOpacity(0.4)
              : greenColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: (isGreenAlpha ?? false)
              ? greenColor.withOpacity(0.4)
              : greenColor,
        ),
      ),
    );
  }
}*/

// class MultiSelect extends StatefulWidget {
//   int category;
//
//   MultiSelect({Key? key, required this.category}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectState();
// }
//
// class _MultiSelectState extends State<MultiSelect> {
//   List _selectedItems = [];
//   List<PharmaCategory> pharmaCategoryList = [];
//   void _itemChange(PharmaCategory itemValue, bool isSelected) {
//     setState(() {
//       if (isSelected) {
//         _selectedItems.add(itemValue);
//       } else {
//         _selectedItems.remove(itemValue);
//       }
//     });
//     print("this is selected values ${_selectedItems.toString()}");
//   }
//
//   void _cancel() {
//     Navigator.pop(context);
//   }
//
//   void _submit() {
//     List selectedItem = _selectedItems.map((item) => item.id).toList();
//     Navigator.pop(context);
//   }
//
//   // getPharmaCategory(int category) async {
//   //   var headers = {
//   //     'Cookie': 'ci_session=7484a255faa8a60919687a35cf9c56e5c55326d2'
//   //   };
//   //   var request = http.MultipartRequest(
//   //       'POST', Uri.parse('${ApiService.getPharmaCategory}'));
//   //   request.fields.addAll({
//   //     'cat_type': category.toString(),
//   //   });
//   //
//   //   print("request________${request.fields}");
//   //
//   //   request.headers.addAll(headers);
//   //   http.StreamedResponse response = await request.send();
//   //   print('${response.statusCode}_____________statuscode');
//   //
//   //   if (response.statusCode == 200) {
//   //     print('_____________');
//   //
//   //     var finalResult = await response.stream.bytesToString();
//   //     final jsonResponse =
//   //         GetPharmaCategory.fromJson(json.decode(finalResult)).data;
//   //     //Fluttertoast.showToast(msg: "${jsonResponse}");
//   //
//   //     setState(() {
//   //       pharmaCategoryList = jsonResponse ?? [];
//   //     });
//   //   } else {
//   //     //Fluttertoast.showToast(msg: "${detailsData?.message}");
//   //     // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
//   //     // Navigator.push(
//   //     //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
//   //     print(response.reasonPhrase);
//   //   }
//   // }
//
//   bool isChecked = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getPharmaCategory(widget.category);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(builder: (context, setState) {
//       return AlertDialog(
//         title: const Text('Select Multiple Categories'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: pharmaCategoryList
//                 .map((item) =>
//                 CheckboxListTile(
//                   activeColor:primary,
//                   value: _selectedItems.contains(item),
//                   title: Text(item.name!),
//                   controlAffinity: ListTileControlAffinity.leading,
//                   onChanged: (isChecked) => _itemChange(item, isChecked!),
//                 ))
//                 .toList(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: _cancel,
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color:primary),
//             ),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(),
//             child: Text('Submit'),
//             onPressed: () {
//               // _submit();
//               Navigator.pop(context, _selectedItems);
//             }
//             ,
//           ),
//         ],
//       );
//     });
//   }
// }
