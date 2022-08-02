import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_card_software/constants.dart';
import 'package:smart_card_software/models/patient.dart';
import 'package:smart_card_software/my_widgets/rounded_button.dart';
import 'package:smart_card_software/my_widgets/my_texform_field.dart';
import 'package:smart_card_software/db/read.dart' as dbRead;
import 'package:smart_card_software/processes/user_authentication.dart';
import 'package:smart_card_software/screens/patient_screens/patient_details_screen.dart';


class PatientLoginScreen extends StatefulWidget {
  final bool fromDoctor;
  PatientLoginScreen({this.fromDoctor = false});

  @override
  _PatientLoginScreenState createState() => _PatientLoginScreenState();
}



class _PatientLoginScreenState extends State<PatientLoginScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  bool isLoading = false;

  get startLoading => mounted ? setState((){isLoading = true;}) : null;
  get stopLoading => mounted ? setState((){isLoading = false;}) : null;

  Widget loginForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyTextFormField(
            labelText: "Enter your username",
            textEditingController: _usernameController,
            textInputType: TextInputType.number,
            prefixIcon: Icon(Icons.person)
          ),
          MyTextFormField(
              labelText: "Enter your PIN code",
              textEditingController: _pinCodeController,
              textInputType: TextInputType.number,
              prefixIcon: Icon(Icons.lock_rounded)
          )
      ]
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/doc_patient2.jpg"),
                  fit: BoxFit.fill,
                )
              ),
            )
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: AutoSizeText("Login", style: kHeaderTextStyle ),
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: AutoSizeText("Make sure you insert your smart card in the card acceptance device (CAD) before filling in your details ",
                            style: kDefTextStyle.copyWith(color: Colors.black54),
                            textAlign: TextAlign.center,),
                      ),
                      loginForm(context),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText("No smart card yet??", style: kDefTextStyle.copyWith(color: Colors.black) ),
                            TextButton(
                              child: AutoSizeText("Create a virtual smart card", style: kDefTextStyle.copyWith(color: appColor) ),
                              onPressed: () {
                                //todo: move to virtual card creation screen
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      RoundedButton(
                          child: AutoSizeText("Login", style: kDefButtonTextStyle),
                          onTap: () async{
                            startLoading;
                            try {
                              if(!await UserAuthentication(context).patientLogin(username: _usernameController.text, pinCode: _pinCodeController.text)) {
                                debugPrint("patient Login failed");
                                return;
                              }
                               if(await UserAuthentication(context).patientLogin()) {
                                 if(widget.fromDoctor) {
                                   Navigator.pop(context, true);
                                 }else {
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetailsScreen(isPatient: true)));
                               }
                               } else {
                                 return null;
                               }

                            }catch(e) {
                              debugPrint("unable to log the user in");
                              stopLoading;
                              Navigator.pop(context, false);
                            }
                            stopLoading;
                        },
                      )

                    ],
                  ),
                ),
              )
          ),
        ]
      )
    );
  }
}
