import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.hint,
    required this.onSaved,
    required this.validator,
    required this.keyboardType,
  }) : super(key: key);

  final String hint;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: _getBorder(Colors.black),
          focusedBorder: _getBorder(Colors.blue),
          errorBorder: _getBorder(Colors.red),
        ),
        onSaved: onSaved,
        validator: validator,
        keyboardType: keyboardType,
      ),
    );
  }

  InputBorder _getBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(10),
      );
}
