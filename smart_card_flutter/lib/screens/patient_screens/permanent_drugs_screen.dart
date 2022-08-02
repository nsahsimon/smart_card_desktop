import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';

import '../../data/patient_auth_data.dart';
import '../../models/details.dart';
import '../../models/permanent_drugs.dart';
import 'package:smart_card_software/db/read.dart' as dbRead;
import 'package:smart_card_software/db/create.dart' as dbCreate;

class PermanentDrugsScreen extends StatefulWidget {
  final bool isPatient;
  PermanentDrugsScreen({this.isPatient = false});

  @override
  _PermanentDrugsScreenState createState() => _PermanentDrugsScreenState();
}

class _PermanentDrugsScreenState extends State<PermanentDrugsScreen> {

  String title = "PERMANENT DRUGS";

  TextEditingController newDrugNameController = TextEditingController();
  TextEditingController newDoseController = TextEditingController();

  List<PermanentDrugs> permanentDrugs = [];
  Future<void> initializeFields() async{
    PatientData patientData = Provider.of<PatientData>(context, listen: false);
    permanentDrugs = await dbRead.getPermanentDrugs(patient_id: patientData.patientId ?? "" );
    if(permanentDrugs.isEmpty) {
      permanentDrugs.add(
          PermanentDrugs(
              dosage: "",
              medicationName: ""
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
                      permanentDrugs.length,
                          (index) => MyTextFormField(
                        labelText: "",
                        isEnabled: false,
                        textColor: Colors.red,
                        textEditingController: TextEditingController(
                            text: permanentDrugs[index].medicationName),
                        suffixIWidget: AutoSizeText("${permanentDrugs[index].dosage}"),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  !widget.isPatient ? MyTextFormField(
                      multipleLines: true,
                      labelText: "Add New Drug",
                      textEditingController: newDrugNameController) : Container(child: null),
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
                    child: AutoSizeText("Add New Drug", style: kDefButtonTextStyle, maxLines: 1,),
                    onTap: () async{
                      debugPrint("creating new permanent drug");
                      PatientData patientData = Provider.of<PatientData>(
                          context, listen: false);
                      debugPrint("rounded button tapped");
                      dbCreate.createPermanentDrug(
                          patient_id: patientData.patientId ?? "",
                          permanentDrug: PermanentDrugs(
                              medicationName: newDrugNameController.text,
                              dosage: newDoseController.text));
                      debugPrint("Adding new permanent drug");
                      await initializeFields();
                      setState(() {});
                      newDoseController.clear();
                      newDrugNameController.clear();
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
