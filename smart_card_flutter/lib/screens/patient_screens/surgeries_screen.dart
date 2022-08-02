import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/models/allergy.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';

import '../../models/details.dart';

class SurgeriesScreen extends StatefulWidget {
  final bool isPatient;
  SurgeriesScreen({this.isPatient = false});

  @override
  _SurgeriesScreenState createState() => _SurgeriesScreenState();
}

class _SurgeriesScreenState extends State<SurgeriesScreen> {

  String title = "IMMUNIZATIONS (VACCINES)";

  TextEditingController newSurgeryController = TextEditingController();

  List<Details> surgeries = [
    Details(
      title: "TyphoidVaccines",
      date: "02-07-2001",
    )
  ];


  void initializeFields() {

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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              AutoSizeText("$title", style: kHeaderTextStyle, maxLines: 1, textAlign: TextAlign.center,),
              ...List<MyTextFormField>.generate(
                  surgeries.length,
                      (index) => MyTextFormField(
                    labelText: "",
                    isEnabled: false,
                    textColor: Colors.red,
                    textEditingController: TextEditingController(
                        text: surgeries[index].title),
                    suffixIWidget: AutoSizeText("${surgeries[index].date}"),
                  )),
              SizedBox(
                height: 20,
              ),
              MyTextFormField(
                  multipleLines: true,
                  labelText: "Add New Surgery",
                  textEditingController: newSurgeryController),
              SizedBox(
                height: 20,
              ),
              !widget.isPatient
                  ? RoundedButton(
                child: AutoSizeText("Add Allergy", style: kDefButtonTextStyle, maxLines: 1,),
                onTap: () {
                  debugPrint("rounded button tapped");
                  //todo: Add Allergy logic
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
}
