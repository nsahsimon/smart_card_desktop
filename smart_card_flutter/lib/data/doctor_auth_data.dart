import 'package:flutter/material.dart';

import '../models/doctor.dart';

class DoctorData extends ChangeNotifier {
  String? doctorId;
  String? username;
  String? firstName;
  String? surname;
  String? address;
  String? homePhone;
  String? workPhone;
  String? mobilePhone;
  String? gender;
  String? clinic;

  DoctorData({
    this.address,
    this.doctorId,
    this.firstName,
    this.gender,
    this.homePhone,
    this.mobilePhone,
    this.surname,
    this.username,
    this.workPhone,
    this.clinic,
  });

  void get reset {
    doctorId = null;
    username = null;
    firstName = null;
    surname = null;
    address = null;
    homePhone = null;
    workPhone = null;
    mobilePhone = null;
    gender = null;
    clinic = null;
  }

  void loadFromDoctor(Doctor doctor) {
    doctorId = doctor.doctorId;
    username = doctor.username;
    firstName = doctor.firstName;
    surname = doctor.surname;
    address = doctor.address;
    homePhone = doctor.homePhone;
    workPhone = doctor.workPhone;
    mobilePhone = doctor.mobilePhone;
    gender = doctor.gender;
    clinic = doctor.clinic;
  }
}