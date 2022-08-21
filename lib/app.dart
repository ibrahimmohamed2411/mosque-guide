import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/cubit/mosque_cubit.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/home_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/mosques_map_screen.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/menu_screen.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/themes/app_theme.dart';
import 'inject_container.dart';

class MyApp extends StatelessWidget {
  final AppRoutes appRoutes;
  const MyApp({Key? key, required this.appRoutes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MosqueCubit>()
        ..getCurrentLocation()
        ..getMosques(),
      child: MaterialApp(
        title: 'Mosque Guide',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        supportedLocales: AppLocalizationsSetup.supportedLocales,
        localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
        localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
        locale: Locale('ar'),
        onGenerateRoute: appRoutes.onGenerateRoute,
        // home: HomeScreen(),
      ),
    );
  }
}
