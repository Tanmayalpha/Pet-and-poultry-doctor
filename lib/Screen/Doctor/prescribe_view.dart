import 'dart:io';

import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/ProductApiResponse.dart';
import 'package:eshopmultivendor/Screen/Doctor/DoctorHomeScreen.dart';
import 'package:eshopmultivendor/Screen/Doctor/search_from.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
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
  ProductDataList? selectedProductData;

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: white,
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          'Prescribed',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                width: widthSize / 1,
                decoration: BoxDecoration(
                    border: Border.all(color: primary2),
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
                          style: TextStyle(color: primary2, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Dr.${name}',
                                style: TextStyle(
                                    color: primary2,
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
                                    color: primary2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                              Text(
                                mobile ?? '',
                                style: TextStyle(
                                    color: primary2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: widthSize / 2.5,
                            child: Text(
                              address ?? '',
                              style: TextStyle(
                                  color: primary2,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
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
                                    color: primary2,
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
                            /* const Text('Res',
                                style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),*/
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
                            /*const SizedBox(
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
                            ),*/
                            const Text('Date:',
                                style: TextStyle(
                                    color: primary2,
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
                                    hintStyle: TextStyle(color: primary2)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            selectedProductData == null ? SizedBox() : selectedProducttype(),
                                 InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SearchMedicine(),
                                          )).then((value) {
                                        if (value != null) {
                                          print("_______${value}_______");
                                          selectedProductData = value;
                                          selectedProduct.add(selectedProductData!);
                                          prescriptions.add(Prescription());
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 10, left: 8,right: 8),
                                      width: widthSize / 2.5,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: primary2),
                                      ),
                                      child: Text(
                                        selectedProductData==null?
                                        'Add Medicine' : 'Add more ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: heightSize / 4,
                              width: widthSize / 1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primary2)),
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

  Widget selectedProducttype() {
    return Column(
      children: <Widget>[
        for (int index = 0; index < prescriptions.length; index++)
          PrescriptionItem(
            prescribedList: prescriptions,
            index: index,
            prescription: selectedProduct[index] ,
            onTimeChanged: (time) {
              setState(() {
                prescriptions[index].time = time;
              });
            },
            onQuantityChanged: (quantity) {
              setState(() {
                prescriptions[index].quantity = quantity;
              });
            },
          ),
        /*ElevatedButton(
          child: Text('Add More'),
          onPressed: () {
            setState(() {
              prescriptions.add(Prescription());
              print("_______${prescriptions.length}___fdfsfdf____");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchMedicine(),
                  )).then((value) {
                if (value != null) {
                  print("_______${value}_______");
                  selectedProductData = value;
                  prescriptions.add(Prescription());
                  selectedProduct.add(selectedProductData!);
                  print("_______${selectedProduct.length}_______");
                  setState(() {});
                }
              });
            });
          },
        )*/
      ],
    );
  }

  String? name;
  String? signature;
  String? mobile;
  String? address;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  String? medicineId;
  List<Prescription> prescriptions = [];

  getUserDetails() async {
    name = await getPrefrence(Username);
    signature = await getPrefrence(Signature);
    mobile = await getPrefrence(Mobile);
    address = await getPrefrence(Address);
    setState(() {});
  }

  Widget wrapTextView() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primary2),
      ),
      child: Wrap(
        children: selectedProduct.map((item) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Chip(
                  backgroundColor: primary2,
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
                      onTap: () {
                        selectedProduct
                            .removeWhere((element) => element == item);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.highlight_remove,
                        size: 20,
                        color: primary2,
                      )))
            ],
          );
        }).toList(),
      ),
    );
  }

  Future<void> submitPrescription() async {
    if (selectedProduct.isEmpty) {
      setDoctorSnackbar('please select medicine', context);
    } else if (prescriptionController.text.isEmpty) {
      setDoctorSnackbar('please add prescription', context);
    } else {
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

class Prescription {
  String? medicine;
  String? time;
  int? quantity;

  Prescription({this.medicine, this.time, this.quantity});
}

// List to store prescriptions

class PrescriptionItem extends StatelessWidget {
  final ProductDataList prescription;
  final ValueChanged onTimeChanged;
  final ValueChanged onQuantityChanged;
  final int index;
  final List<Prescription> prescribedList;

  PrescriptionItem({
    Key? key,
    required this.prescribedList,
    required this.prescription,
    required this.onTimeChanged,
    required this.index,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (prescription.name != null) ...[
          Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 10,top: 10),
            height: 40,
            width: double.maxFinite,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primary2),
            child: Text(
              "${prescription.name}",
              overflow: TextOverflow.ellipsis,

              style: TextStyle(color: white),
              //item.name
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primary2 ),
                  child: TextFormField(
                    style: TextStyle(color: white),
                      onChanged: onTimeChanged,
                      decoration: InputDecoration(hintText: 'Schedule' )) /*DropdownButtonHideUnderline(
                    child: DropdownButton<String>(

                      isExpanded: true,
                      value: prescribedList[index].time,
                      hint: Text('Select Time'),
                      onChanged: onTimeChanged,
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: primary2,
                      style: TextStyle(color: white),
                      items: <String>[
                        'Morning',
                        'Afternoon',
                        'Evening',
                        // Add more times here
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )*/,
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: primary2 ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      borderRadius: BorderRadius.circular(10),
                      dropdownColor: primary2,
                      style: TextStyle(color: white),
                      value: prescribedList[index].quantity,
                      hint: Text('Quantity'),
                      onChanged: onQuantityChanged,
                      items: <int>[1, 2, 3, 4, 5]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
        SizedBox(height: 10),
      ],
    );
  }
}
