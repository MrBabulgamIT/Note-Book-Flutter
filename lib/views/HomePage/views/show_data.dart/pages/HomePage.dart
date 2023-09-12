import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_book/views/HomePage/controller/imagePickerContr.dart';
import 'package:note_book/views/HomePage/views/add_item/additem.dart';
import 'package:note_book/views/HomePage/views/show_data.dart/pages/showdetails.dart';
import 'package:note_book/widget/colorwidget.dart';
import 'package:note_book/widget/dawerWidget.dart';
import 'package:note_book/widget/text.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController carouselController = Get.put(CarouselController());
  final ImagePickerController imageController =
      Get.put(ImagePickerController());
  String imagePathh =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThsyVVdxkz5zyuE-yRKpdwtre_R234HkS2gQ&usqp=CAU";
  bool isExpanded = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    imageController.uploadFirstoreData();
    // TODO: implement initState
    super.initState();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: MyDrawer(),
          key: _scaffoldKey,
          backgroundColor: Color.fromARGB(255, 248, 248, 248),
          floatingActionButton: FloatingActionButton(
            backgroundColor: cPrimaryColor,
            onPressed: () {
              Get.to(AddItemPage());
            },
            child: Icon(Icons.add),
          ),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.25,
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.25 - 27,
                      padding: const EdgeInsets.only(
                          left: cDefaultPadding,
                          right: cDefaultPadding,
                          bottom: 36 + cDefaultPadding),
                      decoration: const BoxDecoration(
                        color: cPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(5.h),
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: Offset(0, 10))
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState!.openDrawer();

                                  //  Get.to(MyDrawer());
                                },
                                child: Image(
                                  image: const AssetImage(
                                    "images/more.png",
                                  ),
                                  color: cPrimaryColor,
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Hi Jony",
                                  style: GoogleFonts.nunito(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const Spacer(),
                              Image(
                                image: const AssetImage(
                                  "images/note.png",
                                ),
                                width: 50.w,
                                height: 50.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          left: cDefaultPadding,
                          right: cDefaultPadding,
                        ),
                        margin: const EdgeInsets.only(
                          left: cDefaultPadding,
                          right: cDefaultPadding,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  offset: Offset(0, 5))
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: ((value) => {}),
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: cPrimaryColor),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.search,
                              size: 30,
                              color: cPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Notes")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        // QuerySnapshot? querySnapshot = snapshot.data;

                        List<Map> items = snapshot.data!.docs
                            .map((e) => e.data() as Map)
                            .toList();

                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              // final firebaseData = snapshot.data!.docs[index];
                              Map firestoreData = items[index];
                              print("image item: ${firestoreData["image"]}");
                              return InkWell(
                                  onTap: () {
                                    Get.to(ShowDetailsPage(
                                      tittle: firestoreData["note_tittle"]
                                          .toString(),
                                      subTittle:
                                          firestoreData["note_discription"]
                                              .toString(),
                                      image: firestoreData.containsKey("image")
                                          ? firestoreData["image"]
                                          : imagePathh,
                                      date:
                                          firestoreData["note_date"].toString(),
                                    ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 10.h),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: Offset(-0, -0))
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          firestoreData.containsKey("image")
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                    firestoreData["image"],
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                    imagePathh,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                MyCustomeText(
                                                    firestoreData[
                                                        "note_tittle"],
                                                    Colors.black,
                                                    ScreenUtil().setSp(19),
                                                    FontWeight.w600),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                MyCustomeText(
                                                    firestoreData[
                                                        "note_discription"],
                                                    Colors.black,
                                                    15.sp,
                                                    FontWeight.w500),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                MyCustomeText(
                                                    firestoreData["note_date"],
                                                    Colors.black,
                                                    15.sp,
                                                    FontWeight.w500),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                            }));
                      }
                      return Text("There's no Notes store here");
                    }),
              )
            ],
          )),
    );
  }
}
