import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';

import '../../config/routes/app_routes.dart';
import '../../features/mosque_guide/presentation/cubit/mosque_cubit.dart';
import '../../features/mosque_guide/presentation/widgets/custom_circle_button.dart';
import '../../features/mosque_guide/presentation/widgets/mosque_info.dart';
import 'app_colors.dart';

class Constant {
  static void showMosqueInfo({
    required BuildContext context,
    required Mosque mosque,
    required LatLng currentLocation,
  }) {
    BlocProvider.of<MosqueCubit>(context).getDirections(
      currentLocation,
      LatLng(mosque.location.latitude, mosque.location.longitude),
    );
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) => Column(
        children: [
          MosqueInfo(
            mosque: mosque,
          ),
          CustomCircleButton(
            backgroundColor: AppColors.brightGreen,
            onPressed: () {
              if (BlocProvider.of<MosqueCubit>(context).state
                  is DirectionsLoadedState) {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  AppRoutes.mapDetailsScreen,
                  arguments: {
                    'mosque': mosque,
                    'currentLocation': currentLocation,
                    'placeDirections': ((BlocProvider.of<MosqueCubit>(context)
                            .state) as DirectionsLoadedState)
                        .placeDirections,
                  },
                );
              }
            },
            icon: Icon(
              Icons.arrow_forward,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
