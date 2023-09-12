import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_book/views/HomePage/views/add_item/additem.dart';
import 'package:note_book/widget/colorwidget.dart';
import 'package:note_book/widget/text.dart';

class MyDrawer extends StatelessWidget {
  String imagePath =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThsyVVdxkz5zyuE-yRKpdwtre_R234HkS2gQ&usqp=CAU";
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: cPrimaryColor,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imagePath,
                    height: 75.h,
                    width: 75.w,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MyCustomeText(
                        "samiul Alim Jony", Colors.white, 18, FontWeight.w600),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    MyCustomeText("samiul.jony@bsrm.com", Colors.white, 18,
                        FontWeight.w600),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title: MyCustomeText("Home", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          Divider(
            color: cPrimaryColor,
            height: 2.h,
          ),
          ListTile(
            leading: Icon(
              Icons.add_reaction_sharp,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title:
                MyCustomeText("Add Note", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Get.to(() => AddItemPage());
            },
          ),
          Divider(
            color: cPrimaryColor,
            height: 2.h,
          ),
          ListTile(
            leading: Icon(
              Icons.share,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title: MyCustomeText("Share", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: cPrimaryColor,
            height: 2.h,
          ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title:
                MyCustomeText("Feedback", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          Divider(
            color: cPrimaryColor,
            height: 2.h,
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title: MyCustomeText(
                "Contact Us", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          Divider(
            color: cPrimaryColor,
            height: 2.h,
          ),
          ListTile(
            leading: Icon(
              Icons.person_pin_circle,
              size: 25.sp,
              color: cPrimaryColor,
            ),
            title:
                MyCustomeText("About Us", Colors.black87, 17, FontWeight.w600),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          Spacer(),
          MyCustomeText(
              "BSRM IT,Chattagram", cPrimaryColor, 17, FontWeight.w700)
        ],
      ),
    );
  }
}
