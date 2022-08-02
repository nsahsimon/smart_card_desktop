import 'package:flutter/material.dart';

class Doctor {
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

  Doctor({
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

}