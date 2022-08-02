// To parse this JSON data, do
//
//     final allergy = allergyFromJson(jsonString);

import 'dart:convert';

Allergy allergyFromJson(String str) => Allergy.fromJson(json.decode(str));

String allergyToJson(Allergy data) => json.encode(data.toJson());

class Allergy {
  Allergy({
    this.allergyName,
    this.allergyDate,
  });

  String? allergyName;
  DateTime? allergyDate;

  factory Allergy.fromJson(Map<String, dynamic> json) => Allergy(
    allergyName: json["allergy_name"],
    allergyDate: DateTime.parse(json["allergy_date"]),
  );

  Map<String, dynamic> toJson() => {
    "allergy_name": allergyName,
    "allergy_date": "${allergyDate!.year.toString().padLeft(4, '0')}-${allergyDate!.month.toString().padLeft(2, '0')}-${allergyDate!.day.toString().padLeft(2, '0')}",
  };
}


