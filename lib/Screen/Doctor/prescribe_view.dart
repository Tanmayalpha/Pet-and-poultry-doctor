import 'dart:io';

import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/ProductApiResponse.dart';
import 'package:eshopmultivendor/Screen/Doctor/DoctorHomeScreen.dart';
import 'package:eshopmultivendor/Screen/Doctor/search_from.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Helper/String.dart';

class PrescribeScreen extends StatefulWidget {
  PrescribeScreen(
      {Key? key, this.petName, this.weight, this.age, this.id, this.clientName})
      : super(key: key);

  String? petName;
  String? age;
  String? weight;
  String? clientName;
  String? id;

  @override
  State<PrescribeScreen> createState() => _PrescribeScreenState();
}

class _PrescribeScreenState extends State<PrescribeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController clientNameController = TextEditingController();
  TextEditingController resController = TextEditingController();
  TextEditingController prescriptionController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController weigthController = TextEditingController();
  TextEditingController batchController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var filesPath;

  String? fileName;
  String? resumeData;

  List<ProductDataList> selectedProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    nameController.text = widget.petName ?? '';
    weigthController.text = widget.weight ?? '';
    ageController.text = widget.age ?? '';
    clientNameController.text = widget.clientName ?? '';
    resController.text = DateTime.now().toString().substring(0, 10) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Center(
            child: Text(
          'Prescribed',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Container(
                height: heightSize / 5.5,
                width: widthSize / 1,
                decoration: BoxDecoration(
                    border: Border.all(color: primary),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: Text(
                          'Pet & Poultry Care Clinic',
                          style: TextStyle(color: primary, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Dr.${name}',
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //Text("Dr.Ajay Malviya",style: TextStyle(color: primary,fontWeight: FontWeight.w700,fontSize:13),),
                            Text(
                              "Res.No. MSVC 7864",
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                            Text(
                              mobile ?? '',
                              style: TextStyle(
                                  color: primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              address ?? '',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Client Name',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: widthSize / 1,
                              child: TextFormField(
                                controller: clientNameController,
                                readOnly: true,
                                validator: (ele) {
                                  if (ele!.isEmpty) {
                                    return 'Please fill all field';
                                  }
                                },
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, left: 15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(11)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Res',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            /*const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: widthSize / 1,
                              child: TextFormField(
                                readOnly: true,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    hintText: '',
                                    hintStyle: TextStyle(color: primary)),
                              ),
                            ),*/
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Patient/Pet/Farm Name',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: widthSize / 1,
                              child: TextFormField(
                                controller: nameController,
                                readOnly: true,
                                validator: (ele) {
                                  if (ele!.isEmpty) {
                                    return 'Please fill all field';
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    hintText: '',
                                    hintStyle: TextStyle(color: primary)),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            const Text('Age',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: widthSize / 1,
                              child: TextFormField(
                                controller: ageController,
                                readOnly: true,
                                validator: (ele) {
                                  if (ele!.isEmpty) {
                                    return 'Please fill all field';
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 10, left: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    hintText: '',
                                    hintStyle: TextStyle(color: primary)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Body Weigth',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            /*SizedBox(
                               width:widthSize/1,
                               child: TextFormField(
                                 validator: (ele){
                                   if(ele!.isEmpty){
                                     return 'Please fill all field';
                                   }
                                 },
                                 decoration: InputDecoration(
                                     contentPadding: const EdgeInsets.only(bottom: 10,left: 15),
                                     border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(11)
                                     ),
                                     hintText: '',hintStyle: TextStyle(color: Colors.blue)
                                 ),
                               ),
                             ),
                             const SizedBox(height: 5,),
                             const Text('Batch Size',style: TextStyle(color: Colors.blue,fontWeight:FontWeight.w400,fontSize: 14)),
                             const SizedBox(height: 5,),*/
                            SizedBox(
                              width: widthSize / 1,
                              child: TextFormField(
                                controller: weigthController,
                                validator: (ele) {
                                  if (ele!.isEmpty) {
                                    return 'Please fill all field';
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    hintText: '',
                                    hintStyle: TextStyle(color: primary)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text('Date:',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: widthSize / 1,
                              child: TextFormField(
                                controller: resController,
                                readOnly: true,
                                validator: (ele) {
                                  if (ele!.isEmpty) {
                                    return 'Please fill all field';
                                  }
                                },
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 15),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(11)),
                                    hintText: '',
                                    hintStyle: TextStyle(color: primary)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchMedicine(),
                                    )).then((value) {
                                  if (value != null) {
                                    print("_______${value}_______");
                                    selectedProduct = value;
                                    setState(() {});
                                  }
                                });
                              },
                              child: selectedProduct.isEmpty
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 10, left: 10),
                                      width: widthSize / 1,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: primary),
                                      ),
                                      child: Text(
                                        'Select Medicine',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )
                                  : wrapTextView(),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: heightSize / 4,
                              width: widthSize / 1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primary)),
                              child: TextFormField(
                                controller: prescriptionController,

                                maxLines: null,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Prescription'),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                children: [
                                  const Text('Signature'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        //showExitPopup();
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 130,
                                      color: Colors.blueGrey.withOpacity(0.3),
                                      child: Image.network(signature ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: 45,
                                width: widthSize / 1,
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ElevatedButton(
                                    onPressed: () {

                                      if (_formKey.currentState!.validate()) {
                                        submitPrescription();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange),
                                    child: const Text(
                                      'Submit Prescription',
                                      style: TextStyle(color: Colors.white),
                                    )))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
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
                      _getFromCamera();
                    },
                    //return false when click on "NO"
                    child: Text('Camera'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _getFromGallery();
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

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      print('image======${imageFile}');
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  String? name;
  String? signature;
  String? mobile;
  String? address;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String? medicineId;

  getUserDetails() async {
    name = await getPrefrence(Username);
    signature = await getPrefrence(Signature);
    mobile = await getPrefrence(Mobile);
    mobile = await getPrefrence(Address);
    setState(() {});
  }

  Widget wrapTextView() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary),
      ),
      child: Wrap(
        children: selectedProduct.map((item) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Chip(
                  backgroundColor: primary,
                  label: SizedBox(
                    width: 150,
                    child: Text(
                      "${item.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                      //item.name
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -.5,
                  child: InkWell(
                      onTap: (){
                        selectedProduct.removeWhere((element) => element == item);
                        setState(() {});
                      },child: Icon(Icons.highlight_remove, size: 20,color: primary,)))
            ],
          );
        }).toList(),
      ),
    );
  }


  Future<void> submitPrescription()async{
    if(selectedProduct.isEmpty){
      setDoctorSnackbar('please select medicine', context);
    }else if(prescriptionController.text.isEmpty){
      setDoctorSnackbar('please add prescription', context);
    }else {
      List<String> stringList = [];

      for (int i = 0; i < selectedProduct.length; i++) {
        stringList.add(selectedProduct[i].id ?? '');
      }
      String result = stringList.join(",");

      var perameter = {
        Id: widget.id,
        Diagnosis: prescriptionController.text,
        Medicine: result
      };

      apiBaseHelper
          .doctorPostAPICall(submitDiagnosisRequest, perameter)
          .then((getData) async {
        bool error = getData["error"];
        String? msg = getData["message"];
        if (!error) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHomeScreen(),
              ));
          setDoctorSnackbar(msg ?? '', context);
        } else {
          setDoctorSnackbar(msg ?? '', context);
        }
      });
    }
  }
}
