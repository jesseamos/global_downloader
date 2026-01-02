import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/utils/utils.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class PlatformLogo extends StatelessWidget {
  final String logoUrl;
  final String name;
  final double height;
  final double width;
  const PlatformLogo({
    super.key,
    required this.logoUrl,
    required this.name,
    this.height = 29,
    this.width = 26,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Image.network(
        logoUrl,
        errorBuilder: (context, error, stackTrace) => SvgIcon(
          svgPath: getSocialIconWithBg(name),
          width: width,
          height: height,
        ),
      ),
    );
  }
}
