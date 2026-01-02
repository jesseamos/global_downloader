import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/icons/auth_icons.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_button.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          btnText: 'Google',
          btnTextStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorsConstant.darkTextSecondary
                : ColorsConstant.blackShade100,
          ),
          icon: SvgIcon(svgPath: googleIcon, size: 24),
          onTap: () {},
          height: 52,
          bgColor: Colors.transparent,
          borderColor: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkGreyBorder
              : ColorsConstant.grey50,
        ),
        const SizedBox(height: 16),
        CustomButton(
          btnText: 'Apple',
          icon: SvgIcon(svgPath: appleIcon, size: 24),
          btnTextStyle: TextStyle(
            fontSize: 13,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorsConstant.darkTextSecondary
                : ColorsConstant.blackShade100,
          ),
          onTap: () {},
          height: 52,
          bgColor: Colors.transparent,
          borderColor: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkGreyBorder
              : ColorsConstant.grey50,
        ),
      ],
    );
  }
}
