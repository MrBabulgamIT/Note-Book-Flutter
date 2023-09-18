import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:note_book/views/HomePage/controller/imagePickerContr.dart';
import 'package:note_book/views/location/controller/controller.dart';
import 'package:note_book/widget/bottomWidget.dart';
import 'package:note_book/widget/colorwidget.dart';
import 'package:note_book/widget/textfield.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final LocationController locationController = Get.put(LocationController());
  @override
  void initState() {
    locationController.getCurrentLocation();
    super.initState();
  }

  Future<void> uploadDataToFirestore() async {
    FirebaseFirestore.instance.collection("Notes").add({
      "note_tittle": tittleController.text,
      "note_discription": subtittleController.text,
      "note_date": dateController.text,
      "images": _imagePickerController.imagePath.value,
      "current_Location":
          "${locationController.locationMessageLatitude},${locationController.locationMesLogitude}",
      "location_address": locationController.locationMessageAddress.value,
    }).then((value) {
      print("Your Data Value Id: ${value.id}");
      Get.back();
    }).catchError((error) => print("Faild to add new note  $error"));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMMMMd('en_US').format(selectedDate);
      });
    }
  }

  final tittleController = TextEditingController();
  final subtittleController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final ImagePickerController _imagePickerController = ImagePickerController();
  //XFile? pickedImage;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: const Text("Add Note"),
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Get.defaultDialog(
                      title: "",
                      content: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 45.h,
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
                              child: GestureDetector(
                                onTap: () async {
                                  _imagePickerController
                                      .imagePicker(ImageSource.camera);
                                  if (_imagePickerController
                                      .imagePath.value.isNotEmpty) {}

                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.camera_rounded,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      "Select Camera",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              height: 45.h,
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
                              child: GestureDetector(
                                onTap: () {
                                  _imagePickerController
                                      .imagePicker(ImageSource.gallery);
                                  if (_imagePickerController
                                      .imagePath.value.isNotEmpty) {}
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.file_open,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Text(
                                      "Select Gallery",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: Container(
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
                        child: Obx(
                            () => _imagePickerController.imagePath.value.isEmpty
                                ? Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 50.sp,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                        File(_imagePickerController
                                            .imagePath.value),
                                        fit: BoxFit.cover),
                                  ))),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextFormField(
                      controller: dateController,

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                      onTap: () => _selectDate(context),

                      // decoration: const InputDecoration(
                      //   labelText: 'Select Date',
                      //   hintText: 'Choose a date',
                      //   prefixIcon: Icon(Icons.calendar_today),
                      // ),
                      decoration: InputDecoration(
                          hintText: 'Select Date',
                          prefixIcon: Icon(Icons.calendar_today),
                          labelStyle: const TextStyle(
                              fontSize: 17, color: Colors.black87),
                          labelText: 'Choose a date',
                          prefixIconColor: cPrimaryColor,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: cPrimaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.cyanAccent)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),

                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableTextFromField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your note tittle';
                      }
                    },
                    controller: tittleController,
                    lebelText: "  Tittle  ",
                    hintText: "Whiten Your note title",
                    maxLine: 2,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableTextFromField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your note Subtittle';
                      }
                    },
                    controller: subtittleController,
                    lebelText: "  Sub Tittle  ",
                    hintText: "Whiten your note",
                    maxLine: 5,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () async {
                        if (globalKey.currentState!.validate()) {
                          await uploadDataToFirestore();
                          _imagePickerController.uploadFirstoreData();
                        }
                      },
                      child: BottomWidget(bottomName: "Add Data")),
                ],
              ),
            ),
          )),
    );
  }
}
