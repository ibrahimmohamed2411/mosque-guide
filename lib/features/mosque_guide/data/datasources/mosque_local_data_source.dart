import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mosque_guide/core/error/exceptions.dart';

abstract class MosqueLocalDataSource {
  Future<LatLng> getCurrentLocation();
}

class MosqueLocalDataSourceImp implements MosqueLocalDataSource {
  final Location location;
  MosqueLocalDataSourceImp({
    required this.location,
  });
  @override
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw CacheException();
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw CacheException();
      }
    }

    LocationData locationData = await location.getLocation();

    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
