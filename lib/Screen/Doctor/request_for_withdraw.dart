import 'dart:convert';
import 'package:eshopmultivendor/Helper/AppBtn.dart';
import 'package:eshopmultivendor/Helper/Color.dart';
import 'package:eshopmultivendor/Helper/Session.dart';
import 'package:eshopmultivendor/Helper/String.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/transaction_list_model.dart';
import 'package:eshopmultivendor/Model/DocterRegisterModel/withdraw_request_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class WithdrawRequestScreen extends StatefulWidget {
  @override
  _WithdrawRequestScreenState createState() => _WithdrawRequestScreenState();
}

class _WithdrawRequestScreenState extends State<WithdrawRequestScreen> {

  List<WithdrawRequest> _withdrawRequests = [
    WithdrawRequest('Ajay Malviya', 'john.doe@example.com', 100.0),
    WithdrawRequest('Jane Smith', 'jane.smith@example.com', 200.0),
    WithdrawRequest('Michael Johnson', 'michael.johnson@example.com', 150.0),
  ];


  @override
  void initState() {
    // TODO: implement initState
    history();
    super.initState();
  }



  String? amount;
  WithdrawRequestModel? sendMessage;

  sendRequest() async {

    var request = http.MultipartRequest(
        'POST',sendWithdrawalRequest);
    request.fields.addAll({
      UserId: "${CUR_USERID}", 'amount':amount.toString(),
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Request = await response.stream.bytesToString();
      final finalRequest = WithdrawRequestModel.fromJson(json.decode(Request));
      setState(() {
        sendMessage = finalRequest;
      });
    } else {
      print(response.reasonPhrase);
    }
  }



  TransactionListModel? historyList;

  Future<void> history() async {
    CUR_USERID = await getPrefrence(UserId);

    var request = http.MultipartRequest(
        'POST', getTransactionHistory);
    request.fields.addAll({
      'user_id': CUR_USERID ?? '',
      'limit': '25',
      'offset': '0',
      'sort': ' id',
      'order': 'DESC'
    });
    request.headers.addAll(doctorHeader);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var Response = await response.stream.bytesToString();
      final finalResponse =
          TransactionListModel.fromJson(json.decode(Response));
      setState(() {
        historyList = finalResponse;
      });
      amount = historyList?.balance;

      print('Amount is here=====${amount}');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text(getTranslated(context, "Withdraw_Request_&_History") ?? '', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${getTranslated(context, "Total_Wallet_Amount")}: ${amount}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            AppButton(titleText: getTranslated(context, "Withdraw_Request"),onTap: (){sendRequest();},),

            SizedBox(height: 16.0),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: _withdrawRequests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(_withdrawRequests[index].name[0]),
                    ),
                    title: Text(_withdrawRequests[index].name),
                    subtitle: Text(_withdrawRequests[index].email),
                    trailing: Text(
                      '\$${_withdrawRequests[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {

                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawRequest {
  final String name;
  final String email;
  final double amount;

  WithdrawRequest(this.name, this.email, this.amount);
}
