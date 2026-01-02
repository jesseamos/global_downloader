import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  bool obscureText;
  Widget? icon;
  final VoidCallback? onTap;
  TextEditingController? controller;
  String? Function(String?)? validation;
  TextInputType? textInputType;
  bool? hasError;
  bool? isEditable;
  String? prefixText;
  Color filledColor;
  double borderRadius;
  int maxLine;
  final String? labelText;
  final String? description;
  final Color borderColor;
  final TextStyle? hintTextStyle;
  final double borderWidth;
  final Function(String)? onChanged;
  final int? maxLength;
  CustomInputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.icon,
    this.onTap,
    this.controller,
    this.validation,
    this.textInputType,
    this.hasError,
    this.isEditable,
    this.prefixText,
    this.filledColor = Colors.transparent,
    this.borderRadius = 8,
    this.maxLine = 1,
    this.labelText,
    this.borderColor = ColorsConstant.greyBorder,
    this.hintTextStyle,
    this.description,
    this.borderWidth = 1,
    this.onChanged,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 14,
              color: ColorsConstant.primaryGreyText,
            ),
          ),
        if (description != null)
          Text(
            description ?? '',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        SizedBox(
          //height: 50,
          child: TextFormField(
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validation,
            maxLength: maxLength,
            obscuringCharacter: '*',
            readOnly: isEditable ?? false,
            controller: controller,
            onTap: onTap,
            maxLines: maxLine,
            keyboardType: textInputType ?? TextInputType.text,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorsConstant.darkTextSecondary
                  : ColorsConstant.primaryBlackText,
            ),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              filled: true,
              fillColor: filledColor == Colors.transparent
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? Colors.transparent
                        : ColorsConstant.white100)
                  : filledColor,
              hintText: hintText,
              suffixIcon: icon != null ? icon : null,
              hintStyle:
                  hintTextStyle ??
                  TextStyle(
                    fontSize: 14,
                    color: ColorsConstant.primaryGreyText,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorsConstant.darkGreyBorder
                      : ColorsConstant.greyBorder,
                  width: borderWidth,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.red, width: borderWidth),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorsConstant.darkGreyBorder
                      : borderColor,
                  width: borderWidth,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ColorsConstant.darkTextSecondary
                      : ColorsConstant.darkGreyBorder,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
