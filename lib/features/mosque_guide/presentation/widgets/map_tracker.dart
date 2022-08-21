import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../inject_container.dart';
import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';

// ignore: must_be_immutable
class MapTracker extends StatefulWidget {
  late LatLng currentLocation;
  final PlaceDirections placeDirections;
  final Mosque mosque;
  MapTracker({
    Key? key,
    required this.currentLocation,
    required this.placeDirections,
    required this.mosque,
  }) : super(key: key);

  @override
  State<MapTracker> createState() => _MapTrackerState();
}

class _MapTrackerState extends State<MapTracker> {
  Completer<GoogleMapController?> _controller = Completer();
  late StreamSubscription<LocationData> liveLocationSubscription;
  void getLocation() {
    Location location = Location();

    liveLocationSubscription =
        location.onLocationChanged.listen((currentLocation) {
      _controller.future.then((mapController) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: 15,
            ),
          ),
        );
      });

      setState(() {
        widget.currentLocation =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  @override
  void dispose() {
    print('dispose map tracker');
    liveLocationSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build map tracker');
    return GoogleMap(
      circles: {
        Circle(
          circleId: CircleId('liveUserLocation'),
          center: widget.currentLocation,
          radius: 30,
          fillColor: Colors.green[600]!,
          strokeColor: AppColors.circleColor.withOpacity(0.7),
          strokeWidth: 20,
        ),
        Circle(
          circleId: CircleId('startLocation'),
          radius: 10,
          center: widget.placeDirections.startLocation,
          fillColor: Colors.green[600]!,
          strokeColor: Colors.green[600]!,
          visible: true,
        )
      },
      markers: {
        Marker(
          markerId: MarkerId('mosque'),
          icon: BitmapDescriptor.fromBytes(sl<Uint8List>()),
          position: LatLng(
            widget.mosque.location.latitude,
            widget.mosque.location.longitude,
          ),
        ),
      },
      polylines: {
        Polyline(
          points: widget.placeDirections.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
          polylineId: PolylineId('route'),
          patterns: [
            PatternItem.gap(10),
            PatternItem.dot,
          ],
          color: AppColors.yellow,
          width: 5,
        ),
      },
      onMapCreated: (GoogleMapController controller) async {
        String style = await DefaultAssetBundle.of(context)
            .loadString('assets/map_style.json');
        controller.setMapStyle(style);
        _controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation,
        // target: initialLocation,
        zoom: 14,
      ),
    );
  }
}
