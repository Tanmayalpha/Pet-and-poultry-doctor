import 'package:eshopmultivendor/Helper/ApiBaseHelper.dart';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/ProductApiResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchMedicine extends StatefulWidget {

  SearchMedicine({Key? key,});


  @override
  _SearchMedicineState createState() => _SearchMedicineState();
}

class _SearchMedicineState extends State<SearchMedicine> {
  // Declare variables to store the user's input and the search suggestions




  final searchController = TextEditingController();

  bool isLoading = false ;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  List<ProductDataList> productList = [];
  List<ProductDataList> selectedProduct = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: primary,),),
        title: Text("Search Product", style: TextStyle(color: primary),),
      ),
      bottomNavigationBar: AppButton(titleText: 'Add Products',onTap: (){addProduct();}),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
              TextFormField(
              onChanged: (vlaue){
              searchProduct(vlaue);
        },
          controller:  searchController ,
          decoration: InputDecoration(
              hintText: 'Search'
          ),
        ),
        SizedBox(height: 16.0),

                isLoading
            ? Center(child: CircularProgressIndicator(),)
            : productList.isEmpty ? Center(
          child: Text('No data found'),) : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) =>
              InkWell(onTap: (){
                //Navigator.pop(context, locationSearchData[index]);
              },
                child: Card(
                  child: ListTile(
                    
                    leading: Image.network(productList[index].image ?? ''),
                    title: Text(productList[index].name ?? ''),
                    trailing: Checkbox(
                      onChanged: (value){
                        productList[index].isSelected = value ;
                        setState(() {
                        });
                      },
                      value: productList[index].isSelected,),
                  ),
                ),
              ),
          // Button to initiate the search
          /*ElevatedButton(
                onPressed: () {
                  // TODO: Implement search functionality
                },
                child: Text("Search"),
              ),*/
        )],
        ),
      ),
    ),);
  }




  Future<void> getProducts () async{
    isLoading =  true;
    setState(() {});

    CUR_USERID = await getPrefrence(UserId);

    var perameter = {UserId: CUR_USERID};

    apiBaseHelper.doctorPostAPICall(getProductsRequest, perameter).then(
            (getData) async{

          bool error = getData["error"];
          String? msg = getData["message"];

          if (!error) {

            productList = GetProductResponse.fromJson(jsonDecode(jsonEncode(getData))).data ?? [] ;

           // acceptedList = PatientRequstResonse.fromJson(jsonDecode(jsonEncode(getData))).data?.accepted ?? [];
            //latestList=   PatientRequstResonse.fromJson(jsonDecode(jsonEncode(getData))).data?.latest ?? [];

            setState(() {
              isLoading =  false ;
            });

          }

        });
  }

  searchProduct(String value) {
    if (value.isEmpty) {
      getProducts();
       setState(() {});
    } else {
      final suggestions = productList.where((element) {
        final productTitle = element.name!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return productTitle.contains(input);
      }).toList();
      productList = suggestions;
      setState(() {});
  }
}

  void addProduct() {
    productList.forEach((element) {
      if(element.isSelected ?? false){
        selectedProduct.add(element);
      }
    });
    Navigator.pop(context, selectedProduct);
  }





}
