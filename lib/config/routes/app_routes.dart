import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosque_guide/features/contact%20us/presentation/cubit/contact_us_cubit.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/mosque.dart';
import 'package:mosque_guide/features/mosque_guide/domain/entities/place_directions.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/about_app_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/home_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/map_details_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/prayer_times_screen.dart';
import 'package:mosque_guide/features/splash/splash_screen.dart';
import 'package:mosque_guide/landing_screen.dart';

import '../../features/contact us/presentation/screens/contact_us_screen.dart';
import '../../inject_container.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String landingScreen = '/landing-screen';
  static const String mosqueMapScreen = '/mosque-map-screen';
  static const String mapDetailsScreen = '/map-details-screen';
  static const String onBoardingScreen = '/on-boarding-screen';
  static const String prayerTimesScreen = '/prayer-times-screen';
  static const String homeScreen = '/home-screen';
  static const String aboutAppScreen = '/about-app-screen';
  static const String contactUsScreen = '/contact-us-screen';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case landingScreen:
        return MaterialPageRoute(
          builder: (context) => LandingScreen(),
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
      case aboutAppScreen:
        return MaterialPageRoute(
          builder: (context) => AboutAppScreen(),
        );
      case contactUsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<ContactUsCubit>(),
            child: ContactUsScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
