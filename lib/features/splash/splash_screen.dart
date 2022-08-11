import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'package:mosque_guide/core/utils/hex_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

void navigate(BuildContext context) {
  Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute);
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  void _goNext() =>
      Navigator.of(context).pushReplacementNamed(AppRoutes.mosqueMapScreen);

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#007E6A'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Image.asset('assets/images/splash.png'),
                    Text(
                      'دليل المساجد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      'اوصل لاقرب مسجد بسهولة',
                      style: TextStyle(
                        color: HexColor('#71C066'),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 90,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
