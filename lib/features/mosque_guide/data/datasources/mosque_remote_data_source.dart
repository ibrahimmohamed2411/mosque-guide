import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mosque_guide/core/api/dio_consumer.dart';
import 'package:mosque_guide/core/api/end_points.dart';
import 'package:mosque_guide/features/mosque_guide/data/models/mosque_model.dart';

import '../../../../core/utils/app_strings.dart';
import '../models/place_directions_model.dart';

abstract class MosqueRemoteDataSource {
  Future<Set<MosqueModel>> getMosques();
  Future<PlaceDirectionsModel> getDirections(LatLng origin, LatLng destination);
  Future<List<MosqueModel>> getMosquesByName(String mosqueName);
}

class MosqueRemoteDataSourceImp implements MosqueRemoteDataSource {
  final DioConsumer dioConsumer;

  final FirebaseFirestore firestore;
  MosqueRemoteDataSourceImp({
    required this.firestore,
    required this.dioConsumer,
  });

  @override
  Future<Set<MosqueModel>> getMosques() async {
    final mosques = await firestore.collection('mosques').get();

    return mosques.docs
        .map((mosque) => MosqueModel.fromJson(mosque.data()))
        .toSet();
  }

  Future<PlaceDirectionsModel> getDirections(
      LatLng origin, LatLng destination) async {
    final response =
        await dioConsumer.get(EndPoints.directions, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': AppStrings.googleApiKey,
    });

    return PlaceDirectionsModel.fromJson(response);
  }

  Future<List<MosqueModel>> getMosquesByName(String mosqueName) async {
    final mosques = await firestore
        .collection('mosques')
        .where('name', isGreaterThanOrEqualTo: mosqueName)
        .get();
    return mosques.docs
        .map((mosque) => MosqueModel.fromJson(mosque.data()))
        .toList();
  }
}
