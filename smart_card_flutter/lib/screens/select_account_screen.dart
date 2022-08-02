import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_card_software/constants.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/screens/patient_screens/patient_login.dart';
import 'package:smart_card_software/screens/doctor_screens/doctor_login.dart';


class SelectAccountScreen extends StatefulWidget {
  @override
  _SelectAccountScreenState createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/doc_patient.jpg",),
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.4,
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                          "WELCOME",
                          maxLines: 1,
                          style: TextStyle(
                            color: kHeaderTextColor,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                      ),
                      AutoSizeText("Proceed as",style: kDefTextStyle),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RoundedButton(
                            child: AutoSizeText("Doctor", style: kDefButtonTextStyle),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorLoginScreen()));
                            },
                          ),
                          SizedBox(width: 50),
                          RoundedButton(
                            child: AutoSizeText("Patient", style: kDefButtonTextStyle),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PatientLoginScreen()));
                            },
                          )
                        ],
                      )
                    ]

                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
