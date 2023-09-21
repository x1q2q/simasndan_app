import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'general_service.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      GeneralService().showNotif(false, 'Services lokasi masih disable');
      return Future.error('Error');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        GeneralService()
            .showNotif(false, 'User tidak mengijinkan services lokasi');
        return Future.error('Error');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      GeneralService().showNotif(false,
          'Service lokasi permissions dilarang selamanya. Silakan diganti');
      return Future.error('Error');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Map<String, dynamic>?> getAddressFromLatLng(Position posisi) async {
    Map<String, dynamic>? address = {"kab": null, "kec": null, "prov": null};
    await placemarkFromCoordinates(posisi.latitude, posisi.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      final splitKab = place.subAdministrativeArea?.split(' ');
      address["kab"] = splitKab?[1].toLowerCase();
      address["location"] = "${place.subLocality}, ${place.locality}";
      address["full_location"] =
          "${place.thoroughfare}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      GeneralService().showNotif(true, 'Akses lokasi telah didapatkan');
    }).catchError((e) {
      debugPrint(e);
      GeneralService().showNotif(false, 'Gagal mendapatkan lokasi');
    });
    return address;
  }
}
