import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_current_location_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_directions_usecase.dart';
import 'package:mosque_guide/features/mosque_guide/domain/usecases/get_mosque_by_name_usecase.dart';

import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';
import '../../domain/usecases/get_mosques_usecase.dart';

part 'mosque_state.dart';

class MosqueCubit extends Cubit<MosqueState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetMosquesUseCase getMosquesUseCase;
  final GetDirectionUseCase getDirectionUseCase;
  final GetMosquesByNameUseCase getMosquesByNameUseCase;
  MosqueCubit({
    required this.getCurrentLocationUseCase,
    required this.getMosquesUseCase,
    required this.getDirectionUseCase,
    required this.getMosquesByNameUseCase,
  }) : super(HomeInitial());
  Future<void> getCurrentLocation() async {
    final currentLocationOrFailure =
        await getCurrentLocationUseCase(NoParams());
    currentLocationOrFailure.fold(
      (failure) => print('error'),
      (locationData) => emit(
        LocationLoadedState(location: locationData),
      ),
    );
  }

  Future<void> getMosques() async {
    final mosquesOrFailure = await getMosquesUseCase(NoParams());
    mosquesOrFailure.fold(
      (failure) => print('error'),
      (mosques) => emit(
        MosquesLoadedState(mosques: mosques),
      ),
    );
  }

  Future<void> getDirections(
    LatLng origin,
    LatLng destination,
  ) async {
    final placeDirectionsOrFailure = await getDirectionUseCase(
        DirectionsParam(origin: origin, destination: destination));
    placeDirectionsOrFailure.fold((failure) => print('Error : $failure'),
        (placeDirections) => emit(DirectionsLoadedState(placeDirections)));
  }

  Future<List<Mosque>> getMosquesByName(String mosqueName) async {
    if (mosqueName.isNotEmpty) {
      final mosquesOrFailure = await getMosquesByNameUseCase(mosqueName);

      final mosques = mosquesOrFailure.fold(
        (failure) =>  List<Mosque>.empty(),
        (mosques) => mosques,
      );
      return mosques;
    }
    return List<Mosque>.empty();
  }
}
