import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';
import 'package:smart_card_software/db/read.dart' as dbRead;
import 'package:smart_card_software/db/create.dart' as dbCreate;


import '../../data/patient_auth_data.dart';
import '../../models/details.dart';

class AllergiesScreen extends StatefulWidget {
  final bool isPatient;
  AllergiesScreen({this.isPatient = false});

  @override
  _AllergiesScreenState createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen> {

  String title = "PATIENT ALLERGIES";

  TextEditingController newAllergyController = TextEditingController();

  List<Allergy> allergies = [];
  Future<void> initializeFields() async{
    PatientData patientData = Provider.of<PatientData>(context, listen: false);
    allergies = await dbRead.getAllergies(patient_id: patientData.patientId ?? "" );
    if(allergies.isEmpty) {
      allergies.add(
          Allergy(
             allergyName: "",
            allergyDate: DateTime.now(),
          )
      );
    }

  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFields(),
      builder: (context, data) {
        return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AutoSizeText("$title", style: kHeaderTextStyle, maxLines: 1, textAlign: TextAlign.center,),
                  ...List<MyTextFormField>.generate(
                        allergies.length,
                        (index) => MyTextFormField(
                            labelText: "",
                            isEnabled: false,
                            textColor: Colors.red,
                            textEditingController: TextEditingController(
                                text: allergies[index].allergyName),
                            suffixIWidget: AutoSizeText("${allergies[index].allergyDate}"),
                        )),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextFormField(
                      multipleLines: true,
                      labelText: "Add New Allergy",
                      textEditingController: newAllergyController),
                  SizedBox(
                    height: 20,
                  ),
                  !widget.isPatient
                      ? RoundedButton(
                          child: AutoSizeText("Add Allergy", style: kDefButtonTextStyle, maxLines: 1,),
                          onTap: () async{
                            debugPrint("creating an allergy");
                            PatientData patientData = Provider.of<PatientData>(context, listen: false);
                            debugPrint("rounded button tapped");
                            dbCreate.createAllergy(patient_id: patientData.patientId ?? "", allergy: Allergy(allergyName: newAllergyController.text, allergyDate: DateTime.now()));
                            debugPrint("allergy creation complete");
                            await initializeFields();
                            setState(() {});
                            newAllergyController.clear();
                          },
                        )
                      : Container(child: null),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
        );
      }
    );
  }
}
