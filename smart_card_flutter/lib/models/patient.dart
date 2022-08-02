import 'package:flutter/material.dart';

class Patient {
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

  Patient({
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
    homePhone = null;
    workPhone = null;
    mobilePhone = null;
    gender = null;
    birthDate = null;
    workPhone = null;

  }

}