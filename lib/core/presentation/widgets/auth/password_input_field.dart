import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/icons/auth_icons.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_input_field.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class PasswordInputField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  PasswordInputField({
    super.key,
    this.hintText = 'Enter password',
    this.labelText = 'Password',
    this.controller,
    this.validation,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  var isPasswordVissible = false;

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      controller: widget.controller,
      obscureText: !isPasswordVissible,
      validation:
          widget.validation ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 8) {
              return 'Password must be at least 6 characters';
            }
            if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
              return 'Password must contain a lowercase letter';
            }
            if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
              return 'Password must contain an uppercase letter';
            }
            if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
              return 'Password must contain a number';
            }
            if (!RegExp(
              r'^(?=.*[!@#\$&*~_.,;:<>?%^()\[\]\{\}\-+=|\\/])',
            ).hasMatch(value)) {
              return 'Password must contain a special symbol';
            }
            return null;
          },

      icon: GestureDetector(
        child: Transform.scale(
          scale: 0.4,
          child: SvgIcon(
            svgPath: isPasswordVissible
                ? passwordVisibleOff
                : passwordVisibleOff,
          ),
        ),
        onTap: () {
          setState(() {
            isPasswordVissible = !isPasswordVissible;
          });
        },
      ),
    );
  }
}
