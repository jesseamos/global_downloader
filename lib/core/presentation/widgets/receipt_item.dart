import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class ReceiptItem extends StatelessWidget {
  final String title;
  final String value;
  final Widget? icon;
  final String? alignIcon;

  const ReceiptItem({
    super.key,
    this.alignIcon,
    this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ColorsConstant.primaryGreyText,
              fontSize: 14,
            ),
          ),

          Row(
            children: [
              if (alignIcon == 'left') ...[
                if (icon != null) icon ?? SizedBox.shrink(),
                if (icon != null) const SizedBox(width: 5),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstant.primaryBlackText,
                  ),
                ),
              ] else ...[
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsConstant.primaryBlackText,
                  ),
                ),
                if (icon != null) const SizedBox(width: 5),
                if (icon != null) icon ?? SizedBox.shrink(),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
