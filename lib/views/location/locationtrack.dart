import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_book/views/location/controller/controller.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    locationController.getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Location "),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 30.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(() => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          locationController.locationMesLogitude.value,
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                        Text(
                          locationController.locationMessageLatitude.value,
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                        Text(
                          locationController.locationMessageAddress.value,
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                onPressed: () {
                  locationController.getCurrentLocation();
                },
                child: const Text("Get Current Location"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Get.to(() => HomePagee(
                  //       latitudeValue: locationController.latitude,
                  //       longitudeValue: locationController.longitude,
                  //     ));
                },
                child: const Text("Get Location Track"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
