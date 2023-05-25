// To parse this JSON data, do
//
//     final doctorDiagnosedRequstResonse = doctorDiagnosedRequstResonseFromJson(jsonString);

import 'dart:convert';

DoctorDiagnosedRequstResonse doctorDiagnosedRequstResonseFromJson(String str) => DoctorDiagnosedRequstResonse.fromJson(json.decode(str));

String doctorDiagnosedRequstResonseToJson(DoctorDiagnosedRequstResonse data) => json.encode(data.toJson());

class DoctorDiagnosedRequstResonse {
  bool? error;
  String? message;
  DoctorDiagnosedAcceptedData? data;

  DoctorDiagnosedRequstResonse({
    this.error,
    this.message,
    this.data,
  });

  factory DoctorDiagnosedRequstResonse.fromJson(Map<String, dynamic> json) => DoctorDiagnosedRequstResonse(
    error: json["error"],
    message: json["message"],
    data: DoctorDiagnosedAcceptedData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data!.toJson(),
  };
}

class DoctorDiagnosedAcceptedData {
  List<Accepted>? accepted;

  DoctorDiagnosedAcceptedData({
    this.accepted,
  });

  factory DoctorDiagnosedAcceptedData.fromJson(Map<String, dynamic> json) => DoctorDiagnosedAcceptedData(
    accepted: List<Accepted>.from(json["accepted"].map((x) => Accepted.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "accepted": List<dynamic>.from(accepted!.map((x) => x.toJson())),
  };
}

class Accepted {
  String? username;
  String? email;
  String? fuid;
  String? mobile;
  String? id;
  String? userId;
  String? animalTypeId;
  String? name;
  String? gender;
  String? age;
  String? weight;
  String? colors;
  String? breed;
  String? species;
  String? disease;
  String? image;
  String? video;
  String? labReport;
  String? description;
  String? status;
  Json? json;
  String? doctorId;
  String? srDoctorId;
  String? rejectedBy;
  String? medicines;
  String? diagnosis;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? doctorName;
  String? doctorEmail;
  String? doctorPhone;
  String? doctorFuid;

  Accepted({
    this.username,
    this.email,
    this.fuid,
    this.mobile,
    this.id,
    this.userId,
    this.animalTypeId,
    this.name,
    this.gender,
    this.age,
    this.weight,
    this.colors,
    this.breed,
    this.species,
    this.disease,
    this.image,
    this.video,
    this.labReport,
    this.description,
    this.status,
    this.json,
    this.doctorId,
    this.srDoctorId,
    this.rejectedBy,
    this.medicines,
    this.diagnosis,
    this.createdAt,
    this.updatedAt,
    this.doctorName,
    this.doctorEmail,
    this.doctorPhone,
    this.doctorFuid,
  });

  factory Accepted.fromJson(Map<String, dynamic> json) => Accepted(
    username: json["username"],
    email: json["email"],
    fuid: json["fuid"],
    mobile: json["mobile"],
    id: json["id"],
    userId: json["user_id"],
    animalTypeId: json["animal_type_id"],
    name: json["name"],
    gender: json["gender"],
    age: json["age"],
    weight: json["weight"],
    colors: json["colors"],
    breed: json["breed"],
    species: json["species"],
    disease: json["disease"],
    image: json["image"],
    video: json["video"],
    labReport: json["lab_report"],
    description: json["description"],
    status: json["status"],
    json: Json.fromJson(json["json"]),
    doctorId: json["doctor_id"],
    srDoctorId: json["sr_doctor_id"],
    rejectedBy: json["rejected_by"],
    medicines: json["medicines"],
    diagnosis: json["diagnosis"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    doctorName: json["doctor_name"],
    doctorEmail: json["doctor_email"],
    doctorPhone: json["doctor_phone"],
    doctorFuid: json["doctor_fuid"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "fuid": fuid,
    "mobile": mobile,
    "id": id,
    "user_id": userId,
    "animal_type_id": animalTypeId,
    "name": name,
    "gender": gender,
    "age": age,
    "weight": weight,
    "colors": colors,
    "breed": breed,
    "species": species,
    "disease": disease,
    "image": image,
    "video": video,
    "lab_report": labReport,
    "description": description,
    "status": status,
    "json": json!.toJson(),
    "doctor_id": doctorId,
    "sr_doctor_id": srDoctorId,
    "rejected_by": rejectedBy,
    "medicines": medicines,
    "diagnosis": diagnosis,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "doctor_name": doctorName,
    "doctor_email": doctorEmail,
    "doctor_phone": doctorPhone,
    "doctor_fuid": doctorFuid,
  };
}

class Json {
  String? nameOfPet;
  String? typeOfPet;
  String? breedOfPet;
  String? sexOfPet;
  String? pregnant;
  String? periodOfPrgnancy;
  String? ageOfPet;
  String? temperature;
  String? weightOfPet;
  String? bodyWeightChanges;
  String? feedConsumptionPerDay;
  String? waterConsumptionPerDay;
  String? avgMilkProduction;
  String? calvingHistory;
  String? vaccination;
  String? vaccineName;
  String? medication;
  String? medicine;
  String? surgery;
  String? typeOfSurgery;
  String? travellingHistory;
  String? symptoms;
  String? stoolConsitancy;
  String? stoolColor;
  String? urineFrequency;
  String? urineColor;
  String? anyChangeWeather;
  String? weather;

  Json({
    this.nameOfPet,
    this.typeOfPet,
    this.breedOfPet,
    this.sexOfPet,
    this.pregnant,
    this.periodOfPrgnancy,
    this.ageOfPet,
    this.temperature,
    this.weightOfPet,
    this.bodyWeightChanges,
    this.feedConsumptionPerDay,
    this.waterConsumptionPerDay,
    this.avgMilkProduction,
    this.calvingHistory,
    this.vaccination,
    this.vaccineName,
    this.medication,
    this.medicine,
    this.surgery,
    this.typeOfSurgery,
    this.travellingHistory,
    this.symptoms,
    this.stoolConsitancy,
    this.stoolColor,
    this.urineFrequency,
    this.urineColor,
    this.anyChangeWeather,
    this.weather,
  });

  factory Json.fromJson(Map<String, dynamic> json) => Json(
    nameOfPet: json["name_of_pet"],
    typeOfPet: json["type_of_pet"],
    breedOfPet: json["breed_of_pet"],
    sexOfPet: json["sex_of_pet"],
    pregnant: json["pregnant"],
    periodOfPrgnancy: json["period_of_prgnancy"],
    ageOfPet: json["age_of_pet"],
    temperature: json["temperature"],
    weightOfPet: json["weight_of_pet"],
    bodyWeightChanges: json["body_weight_changes"],
    feedConsumptionPerDay: json["feed_consumption_per_day"],
    waterConsumptionPerDay: json["water_consumption_per_day"],
    avgMilkProduction: json["avg_milk_production"],
    calvingHistory: json["calving_history"],
    vaccination: json["vaccination"],
    vaccineName: json["vaccine_name"],
    medication: json["medication"],
    medicine: json["medicine"],
    surgery: json["surgery"],
    typeOfSurgery: json["type_of_surgery"],
    travellingHistory: json["travelling_history"],
    symptoms: json["symptoms"],
    stoolConsitancy: json["stool_consitancy"],
    stoolColor: json["stool_color"],
    urineFrequency: json["urine_frequency"],
    urineColor: json["urine_color"],
    anyChangeWeather: json["any_change_weather"],
    weather: json["weather"],
  );

  Map<String, dynamic> toJson() => {
    "name_of_pet": nameOfPet,
    "type_of_pet": typeOfPet,
    "breed_of_pet": breedOfPet,
    "sex_of_pet": sexOfPet,
    "pregnant": pregnant,
    "period_of_prgnancy": periodOfPrgnancy,
    "age_of_pet": ageOfPet,
    "temperature": temperature,
    "weight_of_pet": weightOfPet,
    "body_weight_changes": bodyWeightChanges,
    "feed_consumption_per_day": feedConsumptionPerDay,
    "water_consumption_per_day": waterConsumptionPerDay,
    "avg_milk_production": avgMilkProduction,
    "calving_history": calvingHistory,
    "vaccination": vaccination,
    "vaccine_name": vaccineName,
    "medication": medication,
    "medicine": medicine,
    "surgery": surgery,
    "type_of_surgery": typeOfSurgery,
    "travelling_history": travellingHistory,
    "symptoms": symptoms,
    "stool_consitancy": stoolConsitancy,
    "stool_color": stoolColor,
    "urine_frequency": urineFrequency,
    "urine_color": urineColor,
    "any_change_weather": anyChangeWeather,
    "weather": weather,
  };
}
