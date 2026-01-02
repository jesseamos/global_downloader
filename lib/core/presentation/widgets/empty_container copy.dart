import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class EmptyContainer extends StatelessWidget {
  final String? message;
  const EmptyContainer({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    final double availableHeight =
        MediaQuery.of(context).size.height +
        -kToolbarHeight +
        -MediaQuery.of(context).padding.top;
    return SizedBox(
      height: availableHeight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(svgPath: emptyOrderIcon, width: 110, height: 96.51),
            SizedBox(height: 11),
            Text(
              message ?? 'No Recent Orders',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
