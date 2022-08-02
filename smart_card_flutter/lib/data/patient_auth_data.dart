import 'package:flutter/material.dart';

import '../models/patient.dart';

class PatientData extends ChangeNotifier {
  String? patientId;
  String? username;
  String? firstName;
  String? surname;
  String? address;
  String? homePhone;
  String? workPhone;
  String? mobilePhone;
  String? birthDate;
  String? gender;
  String? bloodType;

  PatientData({
    this.address,
    this.patientId,
    this.birthDate,
    this.bloodType,
    this.firstName,
    this.gender,
    this.homePhone,
    this.mobilePhone,
    this.surname,
    this.username,
    this.workPhone,
  });

  void get reset {
    patientId = null;
    username = null;
    firstName = null;
    surname = null;
    address = null;
    bloodType = null;
    homePhone = null;
    workPhone = null;
    mobilePhone = null;
    gender = null;
    birthDate = null;

  }

  void loadFromPatient(Patient patient) {
    patientId = patient.patientId;
    username = patient.username;
    firstName = patient.firstName;
    surname = patient.surname;
    address = patient.address;
    homePhone = patient.homePhone;
    workPhone = patient.workPhone;
    bloodType = patient.bloodType;
    mobilePhone = patient.mobilePhone;
    gender = patient.gender;
    birthDate = patient.birthDate;
  }
}