import 'dart:core';
import 'dart:core';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key,
    required this.title,
    required this.controller,
    this.fieldkey,
    this.isPasswordField,
    this.hintText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final String title;
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldkey,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      cursorColor: Colors.blueAccent,
      controller: widget.controller,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
      obscureText: widget.isPasswordField == true ? _obscureText : false,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: widget.title,
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 8, 15),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: widget.isPasswordField == true
              ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility)
              : SizedBox(),
        ),
      ),
    );
  }
}
