import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:smart_card_software/data/patient_auth_data.dart';

class PatientGeneralInfoScreen extends StatefulWidget {
  final bool isPatient;
  PatientGeneralInfoScreen({this.isPatient = false});

  @override
  _PatientGeneralInfoScreenState createState() => _PatientGeneralInfoScreenState();
}

class _PatientGeneralInfoScreenState extends State<PatientGeneralInfoScreen> {

  String title = "GENERAL INFORMATION";

  TextEditingController _patientIDController = TextEditingController();
  TextEditingController _patientNameController = TextEditingController();
  TextEditingController _patientSurnameController = TextEditingController();
  TextEditingController _patientAddressController = TextEditingController();
  TextEditingController _homePhoneController = TextEditingController();
  TextEditingController _workPhoneController = TextEditingController();
  TextEditingController _mobilePhoneController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  DateTime? _birthDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _birthDate = picked;
        _birthDateController.text =  "${picked!.day} - ${picked!.month} - ${picked!.year}";
      });
    }
  }

  void initializeFields() {
    PatientData _patientData = Provider.of<PatientData>(context, listen: false);
    _patientIDController.text = _patientData.patientId ?? "";
    _patientNameController.text = _patientData.firstName ?? "";
    _patientSurnameController.text = _patientData.surname ?? "";
    _patientAddressController.text = _patientData.address ?? "";
    _homePhoneController.text = _patientData.homePhone ?? "";
    _workPhoneController.text = _patientData.workPhone ?? "";
    _mobilePhoneController.text = _patientData.mobilePhone ?? "";
    _birthDateController.text = _patientData.birthDate ?? "";
    _bloodTypeController.text = _patientData.bloodType ?? "";
    _genderController.text = _patientData.gender ?? "";

  }

  @override
  void initState() {
    super.initState();
    initializeFields();
  }
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            AutoSizeText("$title", style: kHeaderTextStyle, maxLines: 1, textAlign: TextAlign.center,),
            MyTextFormField(labelText: "Patient ID", textEditingController: _patientIDController, isEnabled: false,),
            MyTextFormField(labelText: "Surname", textEditingController: _patientSurnameController, isEnabled: widget.isPatient,),
            MyTextFormField(labelText: "Name", textEditingController: _patientNameController, isEnabled: widget.isPatient,),
            MyTextFormField(labelText: "Address", textEditingController: _patientAddressController, isEnabled: widget.isPatient,),
            MyTextFormField(labelText: "Home Phone", textEditingController: _homePhoneController, isEnabled: widget.isPatient, textInputType: TextInputType.number,),
            MyTextFormField(labelText: "Work Phone", textEditingController: _workPhoneController, isEnabled: widget.isPatient, textInputType: TextInputType.number,),
            MyTextFormField(labelText: "Mobile Phone", textEditingController: _mobilePhoneController, isEnabled: widget.isPatient, textInputType: TextInputType.number,),
            MyTextFormField(labelText: "Date of birth",
              textEditingController: _birthDateController,
              isEnabled: widget.isPatient,
              textInputType: TextInputType.number,
              suffixIWidget: IconButton(
                icon: Icon(
                    Icons.calendar_today,
                    color: appColor),
                onPressed: () async {
                    print("DOB button pressed");
                    await _selectDate(context);
                }
    ),
    ),
            MyTextFormField(
              labelText: "Blood Type",
              textEditingController: _bloodTypeController,
              isEnabled: widget.isPatient,
              suffixIWidget: DropdownButton<String>(
                underline: Container(child: null),
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.keyboard_arrow_down, color: appColor),
                items: kBloodGroups.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: AutoSizeText(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _bloodTypeController.text = newValue ?? "";
                  });
                },
              ),
            ),
            MyTextFormField(
              labelText: "Gender",
              textEditingController: _genderController,
              isEnabled: widget.isPatient, // widget.isPatient,
              suffixIWidget: DropdownButton<String>(
                underline: Container(child: null),
                alignment: Alignment.centerLeft,
                icon: Icon(Icons.keyboard_arrow_down, color: appColor),
                items: kGenders.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: AutoSizeText(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _genderController.text = newValue ?? "";
                  });
                },
              ),
            ),

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
      )
    );
  }
}
