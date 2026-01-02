import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class CircleBadge extends StatelessWidget {
  final String icon;
  final String? routeName;
  final Color? bgColor;
  final Color? colorIcon;

  const CircleBadge({
    super.key,
    required this.icon,
    this.routeName,
    this.bgColor,
    this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: routeName != null
          ? () {
              context.push(routeName ?? '');
            }
          : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? Colors.white,
        ),

        child: Transform.scale(
          scale: 0.40,
          child: SvgIcon(svgPath: icon, size: 18, color: colorIcon),
        ),
      ),
    );
  }
}
