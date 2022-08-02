import 'package:flutter/material.dart';
import 'package:smart_card_software/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RoundedButton extends StatelessWidget {
  final double radius;
  final Function? onTap;
  final Widget child;
  RoundedButton({this.radius = 20, this.onTap, this.child = const AutoSizeText("NULL", maxLines: 1, style: TextStyle(color: kButtonTextColor, fontSize: kButtonTextSize))});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        onTap == null ? null : onTap!();
      },
      child: Container(
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(radius)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefButtonHPadding, vertical: kDefButtonVPadding),
            child: child,
          ),
        )
      ),
    );
  }
}
