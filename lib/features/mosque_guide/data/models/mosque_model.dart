import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';

class MosqueModel extends Mosque {
  MosqueModel({
    required GeoPoint location,
    required String name,
    required String street,
    required String mosqueStatus,
    required String lessonsCircles,
    required String fridayPrayer,
    required bool availableForWomen,
  }) : super(
          location: location,
          name: name,
          street: street,
          mosqueStatus: mosqueStatus,
          lessonsCircles: lessonsCircles,
          fridayPrayer: fridayPrayer,
          availableForWomen: availableForWomen,
        );
  factory MosqueModel.fromJson(Map<String, dynamic> json) {
    return MosqueModel(
      location: json['location'] as GeoPoint,
      name: json['name'],
      street: json['street'],
      mosqueStatus: json['mosqueStatus'],
      lessonsCircles: json['lessonsCircles'],
      fridayPrayer: json['fridayPrayer'],
      availableForWomen: json['availableForWomen'],
    );
  }
}
