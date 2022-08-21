import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/home_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/mosques_map_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/map_details_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/prayer_times_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/prayer_time_widget.dart';
import 'package:mosque_guide/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:mosque_guide/features/splash/splash_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String mosqueMapScreen = '/mosque-map-screen';
  static const String mapDetailsScreen = '/map-details-screen';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String prayerTimesScreen = '/prayer-times-screen';
  static const String homeScreen = '/home-screen';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
      // case mosqueMapScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => MosquesMapScreen(),
      //   );
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case prayerTimesScreen:
        return MaterialPageRoute(
          builder: (context) => PrayerTimesScreen(),
        );
      case mapDetailsScreen:
        final arguments = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => MapDetailsScreen(
            mosque: arguments['mosque'] as Mosque,
            placeDirections: arguments['placeDirections'] as PlaceDirections,
            currentLocation: arguments['currentLocation'] as LatLng,
          ),
        );

      default:
        return null;
    }
  }
}
