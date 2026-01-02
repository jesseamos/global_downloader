import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'constants.dart';

extension ToLineHeight on num {
  double toLineHeight(num fontSize) {
    return (toDouble() / fontSize).sp;
  }

  Widget toRowSizedBox() {
    return SizedBox(width: toDouble().w);
  }

  Widget toColumnSizedBox() {
    return SizedBox(height: toDouble().h);
  }

  // String toMoney() {
  //   return moneyFormat.format(this);
  // }
}

extension ToCamelCase on String {
  String toCamelCase() {
    return "${split('').first.toUpperCase()}${substring(1).toLowerCase()}";
  }
}
