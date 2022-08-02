import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:smart_card_software/data/patient_auth_data.dart';
import 'package:smart_card_software/data/doctor_auth_data.dart';
import 'package:smart_card_software/models/emergency_contact.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/models/former_chronic_diseases.dart';
import 'package:smart_card_software/models/immunizations.dart';
import 'package:smart_card_software/models/permanent_drugs.dart';

import '../models/doctor.dart';
import '../models/patient.dart';

///gets patient details
Future<Patient?> getPatientDetails({String username = "evariste", String pinCode = "1234"}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewPatientInfo.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'username' : username,
    'pin_code' : pinCode,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      if(result.isEmpty) {
         debugPrint("No patients found");
        return null;
      }
      debugPrint("Birth Date Type: ${result[0]['patient_id'].runtimeType}");
      if(result[0]["username"] != null && result[0]['patient_id'] != null && result[0]['patient_id'] != ""){
        Patient newPatient = Patient(
          patientId: result[0]["patient_id"].toString(),
          username: result[0]["username"],
          firstName: result[0]["first_name"],
          surname: result[0]["surname"],
          address: result[0]["address"],
          homePhone: result[0]["home_phone"],
          workPhone: result[0]["work_phone"],
          birthDate: result[0]["birth_date"],
          gender: result[0]["gender"],
          bloodType: result[0]["blood_type"],
        );
        return newPatient;
      }else {
        return null;
      }
    }catch(e) {
      debugPrint("$e");
      return null;
    }
  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return null;
  }

}

///gets Doctor details
Future<Doctor?> getDoctorDetails({String username = "drlah", String pinCode = "1245687"}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewDoctorInfo.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'username' : username,
    'pin_code' : pinCode,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      if(result.isEmpty) {
        debugPrint("No doctors found");
        return null;
      }
      if(result[0]["username"] != null && result[0]['doctor_id'] != null && result[0]['doctor_id'] != ""){
        Doctor newDoctor = Doctor(
            doctorId: result[0]["doctor_id"].toString(),
            username: result[0]["username"],
            firstName: result[0]["first_name"],
            surname: result[0]["surname"],
            address: result[0]["address"],
            homePhone: result[0]["home_phone"],
            clinic: result[0]["clinic"]
        );
        return newDoctor;
      }else {
        return null;
      }

    }catch(e) {
      debugPrint("$e");
      return null;
    }

    return null;
  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return null;
  }

}

///get emergency contact data
Future<List<EmergencyContact>> getEmergencyContactData({String patient_id = ""}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewEmergencyContact.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'patient_id' : patient_id,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      List<EmergencyContact> emergencyContacts  = [];
      if(result.isEmpty) {
        debugPrint("No emergency contacts found for this patient");
        return [];
      }

      for(Map<String, dynamic> contact in result) {
        emergencyContacts.add(EmergencyContact.fromJson(contact));
      }

      return emergencyContacts;


    }catch(e) {
      debugPrint("$e");
      return [];
    }

  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return [];
  }

}

///get allergies
Future<List<Allergy>> getAllergies({String patient_id = ""}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewAllergyInfo.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'patient_id' : patient_id,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      List<Allergy> allergies  = [];
      if(result.isEmpty) {
        debugPrint("No emergency contacts found for this patient");
        return [];
      }

      for(Map<String, dynamic> allergyData in result) {
        allergies.add(Allergy.fromJson(allergyData));
      }

      return allergies;

    }catch(e) {
      debugPrint("$e");
      return [];
    }

  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return [];
  }

}

///get allergies
Future<List<FormerChronicDisease>> getFormerChronicDiseases({String patient_id = ""}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewDiseaseDetails.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'patient_id' : patient_id,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      List<FormerChronicDisease> formerChronicDiseases  = [];
      if(result.isEmpty) {
        debugPrint("No emergency contacts found for this patient");
        return [];
      }

      for(Map<String, dynamic> allergyData in result) {
        formerChronicDiseases.add(FormerChronicDisease.fromJson(allergyData));
      }

      return formerChronicDiseases;


    }catch(e) {
      debugPrint("$e");
      return [];
    }

  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return [];
  }

}

///get allergies
Future<List<Immunization>> getImmunizations({String patient_id = ""}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewImmunization.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'patient_id' : patient_id,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      List<Immunization> immunizations  = [];
      if(result.isEmpty) {
        debugPrint("No emergency contacts found for this patient");
        return [];
      }

      for(Map<String, dynamic> allergyData in result) {
        immunizations.add(Immunization.fromJson(allergyData));
      }

      return immunizations;


    }catch(e) {
      debugPrint("$e");
      return [];
    }

  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return [];
  }

}

///get allergies
Future<List<PermanentDrugs>> getPermanentDrugs({String patient_id = ""}) async{
  var url = Uri.parse("http://localhost/smart_card_project/php_scripts/viewMedication.php");

  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', url);

  var data = {
    'patient_id' : patient_id,
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    debugPrint("success");
    String? responseString = await response.stream.bytesToString();
    debugPrint("$responseString");

    try{
      List result = await jsonDecode(responseString);
      List<PermanentDrugs> permanentDrugs  = [];
      if(result.isEmpty) {
        debugPrint("No emergency contacts found for this patient");
        return [];
      }

      for(Map<String, dynamic> permDrug in result) {
        permanentDrugs.add(PermanentDrugs.fromJson(permDrug));
      }

      return permanentDrugs;


    }catch(e) {
      debugPrint("$e");
      return [];
    }

  }
  else {
    debugPrint("failed");
    debugPrint(response.reasonPhrase);
    return [];
  }

}
