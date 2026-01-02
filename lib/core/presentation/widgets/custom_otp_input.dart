import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class CustomOtpInput extends StatelessWidget {
  final Function(String)? onSubmit;
  final Color? bgColor;
  final Color? border;
  final double? borderWith;
  final int? numberOfFields;
  final double? borderRadius;
  final double? height;
  const CustomOtpInput({
    super.key,
    this.onSubmit,
    this.bgColor,
    this.border,
    this.borderWith,
    this.numberOfFields,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: OtpTextField(
        borderRadius: BorderRadius.circular(13),
        fillColor: bgColor ?? Colors.white,
        borderWidth: borderWith ?? 2,
        enabledBorderColor: border ?? Colors.transparent,
        filled: true,
        focusedBorderColor: ColorsConstant.primaryColor,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 13),
            borderSide: BorderSide(
              color: ColorsConstant.primaryColor,
              width: 2,
            ),
          ),
        ),
        contentPadding: EdgeInsets.all(5),
        numberOfFields: numberOfFields ?? 6,
        textStyle: TextStyle(
          fontSize: 14,
          color: ColorsConstant.primaryBlackText,
          fontWeight: FontWeight.bold,
        ),
        showFieldAsBox: true,
        fieldWidth:
            (MediaQuery.of(context).size.width - 75) / (numberOfFields ?? 6),
        fieldHeight: height ?? 49,
        onCodeChanged: (String code) {},
        onSubmit: onSubmit,
      ),
    );
  }
}
