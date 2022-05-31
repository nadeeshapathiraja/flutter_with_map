import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class LocationProvider extends ChangeNotifier {
  //...........Access User Location Stata.....................//
  Position? _position;
  Position? get position => _position;

  List<Placemark> _placemarks = [];
  List<Placemark> get placeMark => _placemarks;

  double _distanceInMeters = 0.0;
  double get distanceInMeters => _distanceInMeters;

  String get getAddress =>
      "The Address is ${_placemarks[3].name},${_placemarks[2].street},${_placemarks[0].locality},${_placemarks[0].country}";

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //.....................Get User Codinates
  Future<void> getUserCordinates() async {
    try {
      //get the cordinate and store
      _position = await determinePosition();

      //fetch the address from cordinates
      _placemarks = await placemarkFromCoordinates(
          _position!.latitude, _position!.longitude);

      notifyListeners();
    } catch (e) {
      Logger().e(e);
    }
  }

  //...........Get distance between two locations
  Future<void> getDistance() async {
    try {
      _distanceInMeters = Geolocator.distanceBetween(
          52.2165157, 6.9437819, 52.3546274, 4.8285838);
    } catch (e) {
      Logger().e(e);
    }
  }
}
