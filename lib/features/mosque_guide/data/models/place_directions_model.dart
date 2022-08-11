import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:flutter_polyline_points/src/PointLatLng.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';

class PlaceDirectionsModel extends PlaceDirections {
  PlaceDirectionsModel({
    required LatLngBounds bounds,
    required List<PointLatLng> polylinePoints,
    required String totalDistance,
    required String totalDuration,
    required LatLng startLocation,
  }) : super(
          bounds: bounds,
          polylinePoints: polylinePoints,
          totalDistance: totalDistance,
          totalDuration: totalDuration,
          startLocation: startLocation,
        );
  factory PlaceDirectionsModel.fromJson(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(json['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );
    late String distance;
    late String duration;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return PlaceDirectionsModel(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
      startLocation: LatLng(data['legs'][0]['start_location']['lat'],
          data['legs'][0]['start_location']['lng']),
    );
  }
}
