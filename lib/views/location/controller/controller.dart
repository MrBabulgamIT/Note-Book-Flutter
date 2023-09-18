import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart'; // Import the GetX package
import 'package:geocoding/geocoding.dart' show placemarkFromCoordinates;

class LocationController extends GetxController {
  var locationMessageLatitude = "".obs;
  var locationMesLogitude = "".obs;
  var locationMessageAddress = "".obs;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      final location = Location();
      try {
        final userLocation = await location.getLocation();
        locationMessageLatitude.value = "Latitude: ${userLocation.latitude}";
        locationMesLogitude.value = "Longitude: ${userLocation.longitude}";
        latitude = userLocation.latitude as double;
        longitude = userLocation.longitude as double;

        final addresses = await placemarkFromCoordinates(
          userLocation.latitude!,
          userLocation.longitude!,
        );
        if (addresses.isNotEmpty) {
          final locationAddress = addresses.first;
          String address =
              "Address: ${locationAddress.street}, ${locationAddress.thoroughfare},${locationAddress.locality}-${locationAddress.postalCode}, ${locationAddress.country}";
          locationMessageAddress.value = address;
          print("${userLocation.latitude}, ${userLocation.longitude}");
        }
      } catch (e) {
        locationMesLogitude.value = "Error getting location: $e";
        locationMessageLatitude.value = "Error getting location: $e";
      }
    } else {
      locationMesLogitude.value = "Location permission denied";
      locationMessageLatitude.value = "Location permission denied";
    }
  }
}
