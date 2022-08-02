// To parse this JSON data, do
//
//     final formerChronicDiseases = formerChronicDiseasesFromJson(jsonString);

import 'dart:convert';

FormerChronicDisease formerChronicDiseasesFromJson(String str) => FormerChronicDisease.fromJson(json.decode(str));

String formerChronicDiseasesToJson(FormerChronicDisease data) => json.encode(data.toJson());

class FormerChronicDisease {
  FormerChronicDisease({
    this.diseaseName,
    this.diagnosisDate,
  });

  String? diseaseName;
  DateTime? diagnosisDate;

  factory FormerChronicDisease.fromJson(Map<String, dynamic> json) => FormerChronicDisease(
    diseaseName: json["disease_name"],
    diagnosisDate: DateTime.parse(json["diagnosis_date"]),
  );

  Map<String, dynamic> toJson() => {
    "disease_name": diseaseName,
    "diagnosis_date": "${diagnosisDate!.year.toString().padLeft(4, '0')}-${diagnosisDate!.month.toString().padLeft(2, '0')}-${diagnosisDate!.day.toString().padLeft(2, '0')}",
  };
}
