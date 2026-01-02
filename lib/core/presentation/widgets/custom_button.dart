import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class CustomButton extends StatelessWidget {
  final Color? bgColor;
  final String btnText;
  final Color? borderColor;
  final Widget? icon;
  final VoidCallback? onTap;
  final TextStyle? btnTextStyle;
  final bool isValid;
  final IconAlignment? iconAlignment;
  final double? fontSize;
  final double? height;
  final bool isLoading;
  final double? width;
  final double borderRadiusStrength;
  final Color? textColor;

  const CustomButton({
    super.key,
    this.bgColor,
    required this.btnText,
    this.btnTextStyle,
    this.icon,
    required this.onTap,
    this.iconAlignment,
    this.isValid = false,
    this.height = 52,
    this.fontSize = 16,
    this.borderColor,
    this.isLoading = false,
    this.width = double.infinity,
    this.borderRadiusStrength = 42,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        iconAlignment: iconAlignment,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent, // removes pressed shadow glow
          overlayColor:
              Colors.transparent, // removes splash/hover overlay color
          backgroundColor: bgColor ?? ColorsConstant.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusStrength),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        onPressed: onTap,
        label: Text(
          btnText,
          style:
              btnTextStyle ??
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: textColor ?? Colors.white,
              ),
        ),
        icon: isLoading
            ? Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : icon,
      ),
    );
  }
}
