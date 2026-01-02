import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart'
    show ColorsConstant;
import 'package:spotify_downloader/core/presentation/widgets/custom_back_button.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool noLeadingIcon;
  const CustomAppbar({
    super.key,
    this.title,
    this.actions,
    this.noLeadingIcon = false,
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 50,
      leading: noLeadingIcon == true ? null : CustomBackButton(),
      toolbarHeight: kToolbarHeight + 20,
      backgroundColor: Colors.transparent,
      title: title != null
          ? Text(
              '$title',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : ColorsConstant.primaryBlackText,
                fontWeight: FontWeight.w500,
              ),
            )
          : null,
      centerTitle: true,
      actions: actions,
    );
  }
}
