// To parse this JSON data, do
//
//     final immunization = immunizationFromJson(jsonString);

import 'dart:convert';

Immunization immunizationFromJson(String str) => Immunization.fromJson(json.decode(str));

String immunizationToJson(Immunization data) => json.encode(data.toJson());

class Immunization {
  Immunization({
    this.immunizationName,
    this.immunizationDate,
    this.dose,
  });

  String? immunizationName;
  DateTime? immunizationDate;
  dynamic dose;

  factory Immunization.fromJson(Map<String, dynamic> json) => Immunization(
    immunizationName: json["immunization_name"],
    immunizationDate: DateTime.parse(json["immunization_date"]),
    dose: json["dose"],
  );

  Map<String, dynamic> toJson() => {
    "immunization_name": immunizationName,
    "immunization_date": "${immunizationDate!.year.toString().padLeft(4, '0')}-${immunizationDate!.month.toString().padLeft(2, '0')}-${immunizationDate!.day.toString().padLeft(2, '0')}",
    "dose": dose,
  };
}
