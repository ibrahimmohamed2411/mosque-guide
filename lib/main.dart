import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'inject_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    MyApp(
      appRoutes: AppRoutes(),
    ),
  );
}
