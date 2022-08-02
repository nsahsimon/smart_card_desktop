import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';
import 'package:smart_card_software/models/former_chronic_diseases.dart';

import '../../data/patient_auth_data.dart';
import '../../db/read.dart' as dbRead;
import '../../db/create.dart' as dbCreate;

class FormerChronicDiseases extends StatefulWidget {
  final bool isPatient;
  FormerChronicDiseases({this.isPatient = false});

  @override
  _FormerChronicDiseasesState createState() => _FormerChronicDiseasesState();
}

class _FormerChronicDiseasesState extends State<FormerChronicDiseases> {

  String title = "FORMER CHRONIC DISEASES";

  TextEditingController newChronicDiseaseController = TextEditingController();

  List<FormerChronicDisease> formerChronicDiseases = [];
  Future<void> initializeFields() async{
    PatientData patientData = Provider.of<PatientData>(context, listen: false);
    formerChronicDiseases = await dbRead.getFormerChronicDiseases(patient_id: patientData.patientId ?? "" );
    if(formerChronicDiseases.isEmpty) {
      formerChronicDiseases.add(
          FormerChronicDisease(
            diagnosisDate: DateTime.now(),
            diseaseName: ""
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
                      formerChronicDiseases.length,
                          (index) => MyTextFormField(
                        labelText: "",
                        isEnabled: false,
                        textColor: Colors.red,
                        textEditingController: TextEditingController(
                            text: formerChronicDiseases[index].diseaseName),
                        suffixIWidget: AutoSizeText("${formerChronicDiseases[index].diagnosisDate}"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  MyTextFormField(
                      multipleLines: true,
                      labelText: "Add Disease",
                      textEditingController: newChronicDiseaseController),
                  SizedBox(
                    height: 20,
                  ),
                  !widget.isPatient
                      ? RoundedButton(
                    child: AutoSizeText("Add Disease", style: kDefButtonTextStyle, maxLines: 1,),
                    onTap: () async{
                      debugPrint("creating an chronic disease");
                      PatientData patientData = Provider.of<PatientData>(context, listen: false);
                      debugPrint("rounded button tapped");
                      dbCreate.createChronicDisease(patient_id: patientData.patientId ?? "", chronicDisease: FormerChronicDisease(diseaseName: newChronicDiseaseController.text, diagnosisDate: DateTime.now()));
                      debugPrint("Chronic disease creation complete");
                      await initializeFields();
                      setState(() {});
                      newChronicDiseaseController.clear();
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
