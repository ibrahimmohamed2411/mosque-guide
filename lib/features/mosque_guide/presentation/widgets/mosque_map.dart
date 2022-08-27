import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/core/utils/constants.dart';
import '../../../../inject_container.dart';
import '../../domain/entities/mosque.dart';
import '../cubit/mosque_cubit.dart';

class MosqueMap extends StatefulWidget {
  const MosqueMap({Key? key}) : super(key: key);

  @override
  State<MosqueMap> createState() => _MosqueMapState();
}

class _MosqueMapState extends State<MosqueMap> {
  Completer<GoogleMapController?> _controller = Completer();
  LatLng? _currentLocation;
  Set<Mosque> mosques = Set();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MosqueCubit, MosqueState>(
      listenWhen: (previous, current) => previous!=current,
      listener: (context, state) {
        if (state is MosquesLoadedState) {
          mosques = state.mosques;
        }
        if (state is LocationLoadedState) {
          _currentLocation = state.location;
        }
      },
      builder: (context, state) {
        if (_currentLocation != null) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: GoogleMap(
              zoomControlsEnabled: true,
              markers: {
                ...mosques
                    .map(
                      (mosque) => Marker(
                        icon: BitmapDescriptor.fromBytes(sl<Uint8List>()),
                        onTap: () {
                          Constant.showMosqueInfo(
                            context: context,
                            mosque: mosque,
                            currentLocation: _currentLocation!,
                          );
                        },
                        markerId: MarkerId(
                          '${mosque.name} ${mosque.location.latitude} ${mosque.location.longitude}',
                        ),
                        position: LatLng(mosque.location.latitude,
                            mosque.location.longitude),
                      ),
                    )
                    .toSet(),
              },
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 14,
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(style);
    _controller.complete(controller);
  }
  
}
