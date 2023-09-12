import 'package:flutter/material.dart';
import 'package:note_book/widget/colorwidget.dart';

class BottomWidget extends StatelessWidget {
  BottomWidget({super.key, required this.bottomName, ColorButton});
  String bottomName;
  dynamic colorButton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: cPrimaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
              )
            ]),
        width: double.infinity,
        child: Center(
          child: Text(
            bottomName,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: colorButton),
          ),
        ),
      ),
    );
  }
}
