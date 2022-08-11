import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/custom_circle_button.dart';
import 'package:mosque_guide/inject_container.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/mosque_info.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';

class MapDetailsScreen extends StatefulWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  late LatLng currentLocation;
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
                HemoWidget(
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

class MapTracker extends StatefulWidget {
  LatLng currentLocation;
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
  LatLng initialLocation = LatLng(37.4221, -122.0841);
  Completer<GoogleMapController?> _controller = Completer();
  late StreamSubscription<LocationData> liveLocationSubscription;
  void getLocation() {
    Location location = Location();

    liveLocationSubscription =
        location.onLocationChanged.listen((currentLocation) {
      print('current location: ${currentLocation.latitude}');
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
        // initialLocation =
        //     LatLng(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
    liveLocationSubscription.onError(print);
    liveLocationSubscription.onData((data) {
      print(data);
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
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      circles: {
        Circle(
          circleId: CircleId('currentLocation'),
          center: widget.currentLocation,
          // center: initialLocation,
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
          onTap: () {
            print('circle tapped');
          },
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
        // Marker(
        //   markerId: MarkerId('location'),
        //   // icon: BitmapDescriptor.fromBytes(sl<Uint8List>()),
        //   position: LatLng(
        //     initialLocation.latitude,
        //     initialLocation.longitude,
        //   ),
        // ),
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

class HemoWidget extends StatefulWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  const HemoWidget(
      {Key? key, required this.mosque, required this.placeDirections})
      : super(key: key);

  @override
  State<HemoWidget> createState() => _HemoWidgetState();
}

class _HemoWidgetState extends State<HemoWidget> {
  bool firstWidget = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: GestureDetector(
        onTap: () {
          setState(() {
            firstWidget = false;
          });
        },
        child: BasicInfo(
          mosque: widget.mosque,
          placeDirections: widget.placeDirections,
        ),
      ),
      secondChild: GestureDetector(
        onTap: () {
          setState(() {
            firstWidget = true;
          });
        },
        child: MosqueInfo(
          mosque: widget.mosque,
        ),
      ),
      crossFadeState:
          firstWidget ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
      sizeCurve: Curves.easeInOut,
    );
  }
}

class BasicInfo extends StatelessWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  const BasicInfo({
    Key? key,
    required this.mosque,
    required this.placeDirections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
      height: 150,
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 3,
            thickness: 6,
            indent: 160,
            endIndent: 160,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/marker_icon.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              Expanded(
                child: MyWidget(
                  icon: Icons.place,
                  subtitle: 'المسافة',
                  title: placeDirections.totalDistance,
                ),
              ),
              Expanded(
                child: MyWidget(
                  icon: Icons.timer,
                  subtitle: 'الوقت المتوقع',
                  title: placeDirections.totalDuration,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('مسجد ${mosque.name}'),
              Text(mosque.street),
            ],
          ),
        ],
      ),
    );
  }
}
