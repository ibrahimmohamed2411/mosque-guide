import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mosque {
  final GeoPoint location;
  final String name;
  final String street;
  final String mosqueStatus;
  final String lessonsCircles;
  final String fridayPrayer;
  final bool availableForWomen;
  Mosque({
    required this.location,
    required this.name,
    required this.street,
    required this.mosqueStatus,
    required this.lessonsCircles,
    required this.fridayPrayer,
    required this.availableForWomen,
  });
}
