import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/custom_circle_button.dart';
import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';
import '../widgets/custom_animated_widget.dart';
import '../widgets/map_tracker.dart';

class MapDetailsScreen extends StatefulWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  final LatLng currentLocation;
  MapDetailsScreen({
    required this.mosque,
    required this.placeDirections,
    required this.currentLocation,
  });

  @override
  State<MapDetailsScreen> createState() => _MapDetailsScreenState();
}

class _MapDetailsScreenState extends State<MapDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapTracker(
            mosque: widget.mosque,
            placeDirections: widget.placeDirections,
            currentLocation: widget.currentLocation,
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                CustomAnimatedWidget(
                  mosque: widget.mosque,
                  placeDirections: widget.placeDirections,
                ),
                CustomCircleButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




