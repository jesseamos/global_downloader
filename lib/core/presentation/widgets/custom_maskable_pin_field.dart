import 'package:flutter/material.dart';

class CustomMaskablePinField extends StatefulWidget {
  final String? initialValue; // e.g. "****"
  final Function(String value)? onChanged;

  const CustomMaskablePinField({Key? key, this.initialValue, this.onChanged})
    : super(key: key);

  @override
  State<CustomMaskablePinField> createState() => _CustomMaskablePinFieldState();
}

class _CustomMaskablePinFieldState extends State<CustomMaskablePinField> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(4, (index) {
      return TextEditingController(
        text:
            widget.initialValue != null && widget.initialValue!.length == 4
                ? widget.initialValue![index]
                : '',
      );
    });
  }

  void notify() {
    final value = controllers.map((c) => c.text).join();
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 60,
          child: TextField(
            controller: controllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            obscureText: true,
            obscuringCharacter: '*',
            maxLength: 1,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
              notify();
            },
          ),
        );
      }),
    );
  }
}
