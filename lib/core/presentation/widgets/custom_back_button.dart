import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class CustomBackButton extends StatelessWidget {
  final double? size;
  const CustomBackButton({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.pop,
      child: Container(
        padding: EdgeInsets.only(left: 16),
        child: SvgIcon(svgPath: backButtonIcon, size: size ?? 13),
      ),
    );
  }
}
