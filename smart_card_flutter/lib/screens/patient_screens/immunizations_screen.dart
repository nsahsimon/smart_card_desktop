import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/models/immunizations.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';

import '../../data/patient_auth_data.dart';
import '../../db/read.dart'  as dbRead;
import '../../models/details.dart';
import '../../db/create.dart' as dbCreate;

class ImmunizationsScreen extends StatefulWidget {
  final bool isPatient;
  ImmunizationsScreen({this.isPatient = false});

  @override
  _ImmunizationsScreenState createState() => _ImmunizationsScreenState();
}

class _ImmunizationsScreenState extends State<ImmunizationsScreen> {

  String title = "IMMUNIZATIONS (VACCINES)";

  TextEditingController newImmunizationController = TextEditingController();
  TextEditingController newDoseController = TextEditingController();


  List<Immunization> immunizations = [];
  Future<void> initializeFields() async{
    PatientData patientData = Provider.of<PatientData>(context, listen: false);
    immunizations = await dbRead.getImmunizations(patient_id: patientData.patientId ?? "" );
    if(immunizations.isEmpty) {
      immunizations.add(
          Immunization(
              immunizationDate: DateTime.now(),
              immunizationName: "",
              dose: ""
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
                      immunizations.length,
                          (index) => MyTextFormField(
                        labelText: "",
                        isEnabled: false,
                        textColor: Colors.red,
                        textEditingController: TextEditingController(
                            text: immunizations[index].immunizationName),
                        suffixIWidget: AutoSizeText("${immunizations[index].dose}"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  !widget.isPatient ? MyTextFormField(
                      multipleLines: true,
                      labelText: "Add New Immunization",
                      textEditingController: newImmunizationController) : Container(child: null),
                  !widget.isPatient ? SizedBox(
                    height: 20,
                  ) : Container(child: null),
                  !widget.isPatient ? MyTextFormField(
                      multipleLines: true,
                      labelText: "Add Dosage",
                      textEditingController: newDoseController): Container(child: null),
                  !widget.isPatient ? SizedBox(
                    height: 20,
                  ): Container(child: null),
                  !widget.isPatient
                      ? RoundedButton(
                    child: AutoSizeText("Add Immunization", style: kDefButtonTextStyle, maxLines: 1,),
                    onTap: () async {
                      debugPrint("creating new immunization");
                      PatientData patientData = Provider.of<PatientData>(
                          context, listen: false);
                      debugPrint("rounded button tapped");
                      dbCreate.createImmunization(
                          patient_id: patientData.patientId ?? "",
                          immunization: Immunization(
                              immunizationName: newImmunizationController.text,
                              immunizationDate: DateTime.now(),
                              dose: newDoseController.text));
                      debugPrint("Chronic disease creation complete");
                      await initializeFields();
                      setState(() {});
                      newDoseController.clear();
                      newImmunizationController.clear();
                    })
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
