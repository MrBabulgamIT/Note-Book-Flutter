import 'package:flutter/material.dart';
import 'package:note_book/widget/colorwidget.dart';

class ReusableTextFromField extends StatelessWidget {
  ReusableTextFromField(
      {required this.controller,
      this.data,
      this.formatter,
      this.hintText,
      this.hintTextColor,
      this.initialText,
      this.icon,
      this.keybordType,
      this.keytype,
      this.keyy,
      this.labelTextColor,
      this.onTab,
      this.lebelText,
      this.onChangeFunction,
      this.prefixIcon,
      this.prefixIconColor,
      this.prefixImage,
      this.suffixIcon,
      this.suffixIconColor,
      this.suffixText,
      this.validator,
      this.maxLine,
      this.underlineColor});

  final TextEditingController? controller;
  final Function? onChangeFunction;
  final dynamic icon;
  final dynamic data;
  final int? maxLine;
  final dynamic suffixIcon;
  final dynamic prefixIcon;
  final String? initialText;
  final dynamic validator;
  final String? hintText;
  final String? lebelText;
  final dynamic formatter;
  final dynamic onTab;
  final dynamic keytype;
  final String? suffixText;
  final String? keyy;
  final dynamic keybordType;
  final dynamic prefixImage;
  final Color? labelTextColor;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final Color? hintTextColor;
  final Color? underlineColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keybordType,
          decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              labelStyle: const TextStyle(fontSize: 17, color: Colors.black87),
              labelText: lebelText,
              prefixIconColor: prefixIconColor,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: cPrimaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(width: 2, color: Colors.cyanAccent)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          maxLines: maxLine,
        ));
  }
}
