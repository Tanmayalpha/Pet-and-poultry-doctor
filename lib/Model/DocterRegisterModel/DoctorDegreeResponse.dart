// To parse this JSON data, do
//
//     final doctorDegreeResponse = doctorDegreeResponseFromJson(jsonString);

import 'dart:convert';

DoctorDegreeResponse doctorDegreeResponseFromJson(String str) => DoctorDegreeResponse.fromJson(json.decode(str));

String doctorDegreeResponseToJson(DoctorDegreeResponse data) => json.encode(data.toJson());

class DoctorDegreeResponse {
  bool? error;
  String? message;
  DoctorDegreeData? data;

  DoctorDegreeResponse({
    this.error,
    this.message,
    this.data,
  });

  factory DoctorDegreeResponse.fromJson(Map<String, dynamic> json) => DoctorDegreeResponse(
    error: json["error"],
    message: json["message"],
    data: DoctorDegreeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data!.toJson(),
  };
}

class DoctorDegreeData {
  List<Degree>? degrees;
  List<Degree>? specialization;

  DoctorDegreeData({
    this.degrees,
    this.specialization,
  });

  factory DoctorDegreeData.fromJson(Map<String, dynamic> json) => DoctorDegreeData(
    degrees: List<Degree>.from(json["degrees"].map((x) => Degree.fromJson(x))),
    specialization: List<Degree>.from(json["specialization"].map((x) => Degree.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "degrees": List<dynamic>.from(degrees!.map((x) => x.toJson())),
    "specialization": List<dynamic>.from(specialization!.map((x) => x.toJson())),
  };
}

class Degree {
  String? id;
  String? name;
  DateTime? createdAt;

  Degree({
    this.id,
    this.name,
    this.createdAt,
  });

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
  };
}
