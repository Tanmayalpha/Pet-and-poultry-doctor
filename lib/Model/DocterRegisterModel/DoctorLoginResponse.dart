// To parse this JSON data, do
//
//     final doctorLoginResponse = doctorLoginResponseFromJson(jsonString);

import 'dart:convert';

DoctorLoginResponse doctorLoginResponseFromJson(String str) => DoctorLoginResponse.fromJson(json.decode(str));

String doctorLoginResponseToJson(DoctorLoginResponse data) => json.encode(data.toJson());

class DoctorLoginResponse {
  bool? error;
  String? message;
  List<DoctorLoginData>? data;

  DoctorLoginResponse({
    this.error,
    this.message,
    this.data,
  });

  factory DoctorLoginResponse.fromJson(Map<String, dynamic> json) => DoctorLoginResponse(
    error: json["error"],
    message: json["message"],
    data: List<DoctorLoginData>.from(json["data"].map((x) => DoctorLoginData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DoctorLoginData {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? image;
  String? address;
  DateTime? registerationDate;
  String? specialist;
  String? degreeName;
  String? registerationNo;
  DateTime? validRegisterationDate;
  String? accountNumber;
  String? accountType;
  String? accountHolderName;
  String? bankName;
  String? ifscCode;
  String? branchName;
  String? upiId;
  String? status;
  String? registerationCardFile;
  String? idCardFile;
  String? degreeFile;
  String? certificateFile;
  String? cancelCheque;
  String? signature;

  DoctorLoginData({
    this.id,
    this.username,
    this.email,
    this.mobile,
    this.image,
    this.address,
    this.registerationDate,
    this.specialist,
    this.degreeName,
    this.registerationNo,
    this.validRegisterationDate,
    this.accountNumber,
    this.accountType,
    this.accountHolderName,
    this.bankName,
    this.ifscCode,
    this.branchName,
    this.upiId,
    this.status,
    this.registerationCardFile,
    this.idCardFile,
    this.degreeFile,
    this.certificateFile,
    this.cancelCheque,
    this.signature,
  });

  factory DoctorLoginData.fromJson(Map<String, dynamic> json) => DoctorLoginData(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    image: json["image"],
    address: json["address"],
    registerationDate: DateTime.parse(json["registeration_date"]),
    specialist: json["specialist"],
    degreeName: json["degree_name"],
    registerationNo: json["registeration_no"],
    validRegisterationDate: DateTime.parse(json["valid_registeration_date"]),
    accountNumber: json["account_number"],
    accountType: json["account_type"],
    accountHolderName: json["account_holder_name"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    branchName: json["branch_name"],
    upiId: json["upi_id"],
    status: json["status"],
    registerationCardFile: json["registeration_card_file"],
    idCardFile: json["id_card_file"],
    degreeFile: json["degree_file"],
    certificateFile: json["certificate_file"],
    cancelCheque: json["cancel_cheque"],
    signature: json["signature"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "mobile": mobile,
    "image": image,
    "address": address,
    "registeration_date": registerationDate!.toIso8601String(),
    "specialist": specialist,
    "degree_name": degreeName,
    "registeration_no": registerationNo,
    "valid_registeration_date": "${validRegisterationDate!.year.toString().padLeft(4, '0')}-${validRegisterationDate!.month.toString().padLeft(2, '0')}-${validRegisterationDate!.day.toString().padLeft(2, '0')}",
    "account_number": accountNumber,
    "account_type": accountType,
    "account_holder_name": accountHolderName,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "branch_name": branchName,
    "upi_id": upiId,
    "status": status,
    "registeration_card_file": registerationCardFile,
    "id_card_file": idCardFile,
    "degree_file": degreeFile,
    "certificate_file": certificateFile,
    "cancel_cheque": cancelCheque,
    "signature": signature,
  };
}
