// To parse this JSON data, do
//
//     final emergencyContact = emergencyContactFromJson(jsonString);

import 'dart:convert';

EmergencyContact emergencyContactFromJson(String str) => EmergencyContact.fromJson(json.decode(str));

String emergencyContactToJson(EmergencyContact data) => json.encode(data.toJson());

class EmergencyContact {

  EmergencyContact({
    this.relativeName,
    this.relativeSurname,
    this.relationship,
    this.homephone,
    this.mobilephone,
  });

  String? relativeName;
  String? relativeSurname;
  String? relationship;
  String? homephone;
  String? mobilephone;

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
    relativeName: json["relative_name"],
    relativeSurname: json["relative_surname"],
    relationship: json["relationship"],
    homephone: json["homephone"],
    mobilephone: json["mobilephone"],
  );

  Map<String, dynamic> toJson() => {
    "relative_name": relativeName,
    "relative_surname": relativeSurname,
    "relationship": relationship,
    "homephone": homephone,
    "mobilephone": mobilephone,
  };
}
