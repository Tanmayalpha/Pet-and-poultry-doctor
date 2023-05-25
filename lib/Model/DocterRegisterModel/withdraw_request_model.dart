// To parse this JSON data, do
//
//     final withdrawRequestModel = withdrawRequestModelFromJson(jsonString);

import 'dart:convert';

WithdrawRequestModel withdrawRequestModelFromJson(String str) => WithdrawRequestModel.fromJson(json.decode(str));

String withdrawRequestModelToJson(WithdrawRequestModel data) => json.encode(data.toJson());

class WithdrawRequestModel {
  bool error;
  String message;
  List<dynamic> data;

  WithdrawRequestModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) => WithdrawRequestModel(
    error: json["error"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
