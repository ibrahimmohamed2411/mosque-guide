import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';
import '../../../../core/utils/app_colors.dart';
import '../widgets/mosque_map.dart';
import '../widgets/next_prayer.dart';
import '../widgets/search_field.dart';

class MosquesMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.width,
            height: 240,
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.28,
                    ),
                    Image.asset(
                      'assets/images/main.png',
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'موعد الصلاة القادمة',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(AppRoutes.prayerTimesScreen),
                  child: NextPrayer(),
                ),
                SearchField(),
              ],
            ),
          ),
          Expanded(
            child: MosqueMap(),
          ),
        ],
      ),
    );
  }
}
