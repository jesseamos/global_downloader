import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';
import 'package:spotify_downloader/core/utils/utils.dart';

class OrderCard extends StatelessWidget {
  final String platform;
  final String leadingSubText;
  final TextStyle? leadingSubTextStyle;
  final Widget? iconWidget;
  final String? icon;
  final String status;
  final StatusColors statusColor;
  final String trailingText;
  final TextStyle? trailingTextStyle;
  final Function()? onTap;

  const OrderCard({
    super.key,
    required this.platform,
    required this.leadingSubText,
    this.leadingSubTextStyle,
    this.icon,
    required this.trailingText,
    required this.status,
    required this.statusColor,
    this.trailingTextStyle,
    this.onTap,
    this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            iconWidget ?? SvgIcon(svgPath: icon ?? '', size: 38),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    platform,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    leadingSubText,
                    style:
                        leadingSubTextStyle ??
                        TextStyle(
                          color: ColorsConstant.primaryGreyText,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  trailingText,
                  style:
                      trailingTextStyle ??
                      const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusColor.bgColor,
                    borderRadius: BorderRadius.circular(92),
                  ),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    status,
                    style: TextStyle(
                      fontSize: 9,
                      color: statusColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
