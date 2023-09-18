import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_book/widget/colorwidget.dart';
import 'package:note_book/widget/text.dart';

class ShowDetailsPage extends StatelessWidget {
  ShowDetailsPage(
      {super.key,
      this.tittle,
      this.subTittle,
      this.image,
      this.date,
      this.locationAddress});
  String? tittle;
  String? subTittle;
  String? image;
  String? date;
  String? locationAddress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Note Description"),
            backgroundColor: cPrimaryColor,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 25.sp,
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 300.h,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 5))
                      ],
                      color: Colors.white24,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                          top: Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(image.toString(), fit: BoxFit.cover),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                MyCustomeGoogleFontText(
                    "Your Note Date: ", Colors.black, 22, FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                MyCustomeGoogleFontText(
                    date.toString(), Colors.black, 17, FontWeight.w600),
                SizedBox(
                  height: 15.h,
                ),
                MyCustomeGoogleFontText(
                    "Current Adreess: ", Colors.black, 22, FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                MyCustomeGoogleFontText(
                    locationAddress == null ? " " : locationAddress.toString(),
                    Colors.black,
                    17,
                    FontWeight.w600),
                SizedBox(
                  height: 15.h,
                ),
                MyCustomeGoogleFontText(
                    "Your Note Tittle: ", Colors.black, 22, FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                MyCustomeGoogleFontText(
                    tittle.toString(), Colors.black, 17, FontWeight.w600),
                SizedBox(
                  height: 15.h,
                ),
                MyCustomeGoogleFontText("Your Note Description: ", Colors.black,
                    22, FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ),
                MyCustomeGoogleFontText(
                    subTittle.toString(), Colors.black, 17, FontWeight.w600),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
