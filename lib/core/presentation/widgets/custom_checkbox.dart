import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class CustomCheckbox extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool value;
  const CustomCheckbox({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        value: value,
        checkColor: Colors.white,
        onChanged: onChanged,
        activeColor: ColorsConstant.primaryColor,
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorsConstant.darkTextSecondary
              : ColorsConstant.greyShade100,
          width: 1.5,
        ),
      ),
    );
  }
}
