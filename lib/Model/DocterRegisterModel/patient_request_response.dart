// To parse this JSON data, do
//
//     final patientRequstResonse = patientRequstResonseFromJson(jsonString);

import 'dart:convert';

PatientRequstResonse patientRequstResonseFromJson(String str) => PatientRequstResonse.fromJson(json.decode(str));

String patientRequstResonseToJson(PatientRequstResonse data) => json.encode(data.toJson());

class PatientRequstResonse {
  bool? error;
  String? message;
  PatientData? data;

  PatientRequstResonse({
    this.error,
    this.message,
    this.data,
  });

  factory PatientRequstResonse.fromJson(Map<String, dynamic> json) => PatientRequstResonse(
    error: json["error"],
    message: json["message"],
    data: PatientData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": data!.toJson(),
  };
}

class PatientData {
  List<Accepted>? latest;
  List<Accepted>? accepted;

  PatientData({
    this.latest,
    this.accepted,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
    latest: List<Accepted>.from(json["latest"].map((x) => Accepted.fromJson(x))),
    accepted: List<Accepted>.from(json["accepted"].map((x) => Accepted.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "latest": List<dynamic>.from(latest!.map((x) => x.toJson())),
    "accepted": List<dynamic>.from(accepted!.map((x) => x.toJson())),
  };
}

class Accepted {
  String? username;
  String? email;
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
  String? labReport;
  String? description;
  String? status;
  Json? json;
  String? doctorId;
  String? rejectedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Accepted({
    this.username,
    this.email,
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
    this.labReport,
    this.description,
    this.status,
    this.json,
    this.doctorId,
    this.rejectedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Accepted.fromJson(Map<String, dynamic> json) => Accepted(
    username: json["username"],
    email: json["email"],
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
    labReport: json["lab_report"],
    description: json["description"],
    status: json["status"],
    json: Json.fromJson(json["json"]),
    doctorId: json["doctor_id"],
    rejectedBy: json["rejected_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
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
    "lab_report": labReport,
    "description": description,
    "status": status,
    "json": json!.toJson(),
    "doctor_id": doctorId,
    "rejected_by": rejectedBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
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
  String? typeOfSurgeryRuminotomy;
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
    this.typeOfSurgeryRuminotomy,
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
    typeOfSurgeryRuminotomy: json["type_of_surgery:_Ruminotomy"],
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
    "type_of_surgery:_Ruminotomy": typeOfSurgeryRuminotomy,
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
