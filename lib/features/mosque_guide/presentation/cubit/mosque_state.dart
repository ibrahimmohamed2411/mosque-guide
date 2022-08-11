part of 'mosque_cubit.dart';

abstract class MosqueState extends Equatable {
  const MosqueState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends MosqueState {}

class LocationLoadedState extends MosqueState {
  final LatLng location;
  LocationLoadedState({
    required this.location,
  });
  @override
  List<Object> get props => [location];
}

class LocationLoadingState extends MosqueState {}

class LocationErrorState extends MosqueState {
  final String msg;
  LocationErrorState({
    required this.msg,
  });
  @override
  List<Object> get props => [msg];
}

class MosquesLoadedState extends MosqueState {
  final Set<Mosque> mosques;
  MosquesLoadedState({
    required this.mosques,
  });
  @override
  List<Object> get props => [mosques];
}

class DirectionsLoadedState extends MosqueState {
  final PlaceDirections placeDirections;
  DirectionsLoadedState(this.placeDirections);
  @override
  List<Object> get props => [placeDirections];
}

class MosquesSearchingLoadedState extends MosqueState {
  final List<Mosque> mosques;
  MosquesSearchingLoadedState({
    required this.mosques,
  });
  @override
  List<Object> get props => [mosques];
}
