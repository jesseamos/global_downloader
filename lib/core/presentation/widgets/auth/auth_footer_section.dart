import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class AuthFooterSection extends StatelessWidget {
  final String question;
  final String actionText;
  final Function() onPress;
  final bool noPadding;
  const AuthFooterSection({
    super.key,
    required this.actionText,
    required this.question,
    required this.onPress,
    this.noPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: noPadding ? null : const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ColorsConstant.darkTextSecondary
                  : ColorsConstant.primaryBlackText,
            ),
          ),
          GestureDetector(
            onTap: onPress,
            child: Text(
              actionText,
              style: TextStyle(
                color: ColorsConstant.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
