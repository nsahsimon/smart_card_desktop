import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';

class MyTextFormField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextInputType textInputType;
  final TextEditingController? textEditingController;
  final Icon? prefixIcon;
  final bool isEnabled;
  final Color? textColor;
  final Widget? suffixIWidget;
  final bool multipleLines;
  final String? initialText;

  MyTextFormField({
    this.hintText,
    this.initialText,
    @required this.labelText,
    @required this.textEditingController,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.isEnabled = true,
    this.suffixIWidget,
    this.textColor,
    this.multipleLines = false,
});

  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText("${widget.labelText}", style: kLabelTextStyle),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: widget.textEditingController!,
            keyboardType: widget.textInputType,
            enabled: widget.isEnabled,
            style: TextStyle(color: widget.textColor),
            initialValue: widget.initialText,
            decoration: InputDecoration(
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIWidget,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: appColor),
                borderRadius: BorderRadius.circular(5)
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              )
              
            ),
          )
        ],
      )
    );
  }
}
