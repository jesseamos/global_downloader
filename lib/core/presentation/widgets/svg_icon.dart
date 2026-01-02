import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String svgPath;
  final double size;
  final Color? color;
  final double? width;
  final double? height;
  SvgIcon({
    super.key,
    required this.svgPath,
    this.size = 13,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      svgPath,
      width: width ?? size.w,
      height: height ?? size.h,
      color: color,
    );
  }
}
