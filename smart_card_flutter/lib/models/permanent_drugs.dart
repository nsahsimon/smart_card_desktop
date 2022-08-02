// To parse this JSON data, do
//
//     final permanentDrugs = permanentDrugsFromJson(jsonString);

import 'dart:convert';

PermanentDrugs permanentDrugsFromJson(String str) => PermanentDrugs.fromJson(json.decode(str));

String permanentDrugsToJson(PermanentDrugs data) => json.encode(data.toJson());

class PermanentDrugs {
  PermanentDrugs({
    this.medicationName,
    this.dosage,
  });

  String? medicationName;
  String? dosage;

  factory PermanentDrugs.fromJson(Map<String, dynamic> json) => PermanentDrugs(
    medicationName: json["medication_name"],
    dosage: json["dosage"],
  );

  Map<String, dynamic> toJson() => {
    "medication_name": medicationName,
    "dosage": dosage,
  };
}
