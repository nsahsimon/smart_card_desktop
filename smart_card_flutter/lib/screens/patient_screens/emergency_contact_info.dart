import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/models/emergency_contact.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/db/read.dart' as dbRead;
import 'package:provider/provider.dart';
import 'package:smart_card_software/data/patient_auth_data.dart';

class EmergencyContactInfoScreen extends StatefulWidget {
  final bool isPatient;
  EmergencyContactInfoScreen({this.isPatient = false});

  @override
  _EmergencyContactInfoScreenState createState() => _EmergencyContactInfoScreenState();
}

class _EmergencyContactInfoScreenState extends State<EmergencyContactInfoScreen> {

  String title = "EMERGENCY CONTACT INFO";

  TextEditingController _relativesNameController = TextEditingController();
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController _relativesSurnameController = TextEditingController();
  TextEditingController _homePhoneController = TextEditingController();
  TextEditingController _mobilePhoneController = TextEditingController();

  List<EmergencyContact> emergencyContacts = [];
  Future<void> initializeFields() async{
    PatientData patientData = Provider.of<PatientData>(context, listen: false);
    emergencyContacts = await dbRead.getEmergencyContactData(patient_id: patientData.patientId ?? "" );
    if(emergencyContacts.isEmpty) {
      emergencyContacts.add(
        EmergencyContact(
          relativeName: "",
          relationship: "",
          relativeSurname: "",
          homephone: "",
          mobilephone: ""
        )
      );
    }

    _relativesNameController.text = emergencyContacts[0].relativeName ?? "";
    _relativesSurnameController.text = emergencyContacts[0].relativeSurname ?? "";
    _relationshipController.text = emergencyContacts[0].relationship ?? "";
    _homePhoneController.text = emergencyContacts[0].homephone ?? "";
    _mobilePhoneController.text = emergencyContacts[0].mobilephone ?? "";
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
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText("$title", style: kHeaderTextStyle, maxLines: 1, textAlign: TextAlign.center,),
                    MyTextFormField(labelText: "Relative\'s Name", textEditingController: _relativesNameController, isEnabled: false,),
                    MyTextFormField(labelText: "Relative\'s Surname", textEditingController: _relativesSurnameController,  isEnabled: widget.isPatient,),
                    MyTextFormField(labelText: "Relationship", textEditingController: _relationshipController, isEnabled: widget.isPatient,),
                    MyTextFormField(labelText: "Home Phone", textEditingController: _homePhoneController,isEnabled: widget.isPatient, textInputType: TextInputType.number,),
                    MyTextFormField(labelText: "Mobile Phone", textEditingController: _mobilePhoneController,isEnabled: widget.isPatient, textInputType: TextInputType.number,),
                    SizedBox(
                      height: 20,
                    ),
                    widget.isPatient ? RoundedButton(
                      child: AutoSizeText("Save", style: kDefButtonTextStyle, maxLines: 1,),
                      onTap: () {
                        //todo: Save changes
                      },
                    ) : Container(child: null),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )
        );
      }
    );
  }
}
