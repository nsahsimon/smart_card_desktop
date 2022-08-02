import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_card_software/db/read.dart' as dbRead;
import 'package:smart_card_software/data/patient_auth_data.dart';
import 'package:smart_card_software/data/doctor_auth_data.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/screens/select_account_screen.dart';

import '../models/patient.dart';
import '../models/doctor.dart';


class UserAuthentication {
  static String? doctorId;
  static String? patientId;
  late BuildContext context;
  UserAuthentication(this.context);

  Future<bool> doctorLogin({String? username, String? pinCode}) async {
    Doctor? result = await dbRead.getDoctorDetails(username: username?? "evariste", pinCode: pinCode?? "1234");
    if(result != null) {
      Provider.of<DoctorData>(context, listen: false).loadFromDoctor(result!);
      debugPrint("first_name: ${Provider.of<DoctorData>(context, listen: false).firstName}");
      debugPrint("last_name: ${Provider.of<DoctorData>(context, listen: false).surname}");
      return true;
    } else {
      return false;
    }

  }

  Future<bool> patientLogin({String? username, String? pinCode}) async {
    Patient? result = await dbRead.getPatientDetails(username: username?? "evariste", pinCode: pinCode?? "1234");
    if(result != null) {
      Provider.of<PatientData>(context, listen: false).loadFromPatient(result!);
      debugPrint("first_name: ${Provider.of<PatientData>(context, listen: false).firstName}");
      debugPrint("last_name: ${Provider.of<PatientData>(context, listen: false).surname}");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createDoctorVirtualCard() async{
    return true;
  }

  Future<bool> createPatientVirtualCard() async {
    return true;
  }


  bool signOutUser() {
    Provider.of<DoctorData>(context, listen: false).reset;
    Provider.of<PatientData>(context, listen: false).reset;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectAccountScreen()));
    doctorId = null;
    patientId = null;
    debugPrint("All users have been signed out");
    return true;
  }




}