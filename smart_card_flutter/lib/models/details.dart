import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';

class Details{
  String type = ALLERGY;
  String? date;
  String? title;
  String? dosage;
  String? department;
  String? entryDate;
  String? leaveDate;
  String? oprDate;
  String? reference;
  String? amnesis;
  String? result;

  Details({
    this.type = ALLERGY,
    this.date,
    this.title,
    this.dosage,
    this.entryDate,
    this.department,
    this.leaveDate,
    this.oprDate,
    this.reference,
    this.amnesis,
    this.result,
  });

}
