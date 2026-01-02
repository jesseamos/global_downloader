import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';

class CustomPhoneNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  const CustomPhoneNumberInput({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        // const Text(
        //   'Phone Number',
        //   style: TextStyle(color: Colors.white, fontSize: 14),
        // ),
        SizedBox(
          child: IntlPhoneField(
            disableLengthCheck: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            dropdownIconPosition: IconPosition.trailing,
            dropdownDecoration: BoxDecoration(
              // border: Border(
              //   right: BorderSide(color: ColorsConstant.grey500, width: 2),
              // ),
            ),
            pickerDialogStyle: PickerDialogStyle(
              countryNameStyle: TextStyle(
                fontSize: 14,
                color: ColorsConstant.grey500,
              ),
              searchFieldCursorColor: Colors.white,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: BorderSide(color: Colors.red, width: 1),
              ),
              errorStyle: TextStyle(color: Colors.red, fontSize: 12),
            ),
            initialCountryCode: 'NG',
            style: TextStyle(color: ColorsConstant.grey500, fontSize: 14),
            dropdownTextStyle: TextStyle(
              color: ColorsConstant.grey500,
              fontSize: 16,
            ),
            dropdownIcon: Icon(
              Icons.arrow_drop_down,
              color: ColorsConstant.grey500,
            ),
            onChanged: (phone) {
              controller?.text = '${phone.countryCode}${phone.number}';
            },
            validator: (_) {
              if (controller?.text == null) {
                return 'Please enter your Phone Number';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
