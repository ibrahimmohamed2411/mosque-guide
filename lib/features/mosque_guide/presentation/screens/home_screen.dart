import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../core/utils/app_colors.dart';
import 'menu_screen.dart';
import 'mosques_map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/prayer_times_background.png'),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.brightGreen,
                AppColors.primary,
              ],
            ),
          ),
          child: ZoomDrawer(
            isRtl: true,
            openCurve: Curves.fastOutSlowIn,
            borderRadius: 24.0,
            showShadow: true,
            shadowLayer2Color: Colors.transparent,
            shadowLayer1Color: Colors.white.withOpacity(0.3),
            drawerShadowsBackgroundColor: AppColors.hint,
            angle: 0.0,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            style: DrawerStyle.defaultStyle,
            mainScreen: MosquesMapScreen(),
            menuScreen: MenuScreen(),
          ),
        ),
      ),
    );
  }
}
