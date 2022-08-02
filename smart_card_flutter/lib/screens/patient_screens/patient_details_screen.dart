import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/processes/user_authentication.dart';
import 'package:smart_card_software/screens/patient_screens/general_info_screen.dart';
import 'package:smart_card_software/screens/patient_screens/emergency_contact_info.dart';
import 'package:smart_card_software/screens/patient_screens/former_chronic_diseases_screen.dart';
import 'immunizations_screen.dart';
import 'permanent_drugs_screen.dart';
import 'allergies_screen.dart';
import 'surgeries_screen.dart';

class PatientDetailsScreen extends StatefulWidget {
  final bool isPatient;
  PatientDetailsScreen({this.isPatient = false});

  @override
  _PatientDetailsScreenState createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {

  int selectedTileIndex = 0;


  Map<String, Widget> get patientInfoCategories => {
    "General Patient Info" : PatientGeneralInfoScreen(isPatient: widget.isPatient,),
    "Emergency Contact Info" : EmergencyContactInfoScreen(isPatient: widget.isPatient),
    "Patients allergies" : AllergiesScreen(isPatient: widget.isPatient,),
    "Patients immunizations" : ImmunizationsScreen(isPatient: widget.isPatient),
    "Patients former chronic diseases" : FormerChronicDiseases(isPatient: widget.isPatient,),
    "Drugs permanently used by Patient" : PermanentDrugsScreen(isPatient: widget.isPatient),
    "Surgeries undergone" : SurgeriesScreen(isPatient: widget.isPatient,),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 2,
              child: Container(
                color: appColor,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                        child: TextButton(
                            style: ButtonStyle(
                              alignment: Alignment.centerLeft,
                            ),
                            child: AutoSizeText("Exit",
                              style: kDefTextStyle.copyWith(color: Colors.red),
                              textAlign: TextAlign.start,),
                              onPressed: () {
                                  UserAuthentication(context).signOutUser();
                            }
                        )),
                    ListView.builder(
                    shrinkWrap: true,
                    itemCount: patientInfoCategories.keys.length,
                      itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                            child: TextButton(
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                              ),
                                child: AutoSizeText("${patientInfoCategories.keys.toList()[index]}",
                                    style: kDefTextStyle.copyWith(color: selectedTileIndex == index ? Colors.white : Colors.black),
                                    textAlign: TextAlign.start,),
                                    onPressed: () {
                                      setState(() {
                                        selectedTileIndex = index;
                                      });
                                    }
                              ));
                              },
                            ),]
                ),
                        )
                    ),
            Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                      child: patientInfoCategories.values.toList()[selectedTileIndex]),
                )

            )
              ])
            );

  }
}
