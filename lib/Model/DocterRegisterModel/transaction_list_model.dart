// To parse this JSON data, do
//
//     final transactionListModel = transactionListModelFromJson(jsonString);

import 'dart:convert';

TransactionListModel transactionListModelFromJson(String str) => TransactionListModel.fromJson(json.decode(str));

String transactionListModelToJson(TransactionListModel data) => json.encode(data.toJson());

class TransactionListModel {
  bool error;
  String message;
  String total;
  String balance;
  List<dynamic> data;

  TransactionListModel({
    required this.error,
    required this.message,
    required this.total,
    required this.balance,
    required this.data,
  });

  factory TransactionListModel.fromJson(Map<String, dynamic> json) => TransactionListModel(
    error: json["error"],
    message: json["message"],
    total: json["total"],
    balance: json["balance"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "total": total,
    "balance": balance,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
