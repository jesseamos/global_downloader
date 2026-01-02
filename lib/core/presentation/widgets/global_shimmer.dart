import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class GlobalShimmer extends StatelessWidget {
  final Widget child;

  const GlobalShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? ColorsConstant.darkGreyBorder
          : Colors.grey.shade300,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? ColorsConstant.stroke
          : Colors.grey.shade100,
      child: child,
    );
  }
}
