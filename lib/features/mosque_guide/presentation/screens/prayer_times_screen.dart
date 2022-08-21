import 'package:flutter/material.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';
import 'package:mosque_guide/core/utils/hex_color.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/next_prayer.dart';

import '../widgets/prayer_time_widget.dart';

class PrayerTimesScreen extends StatelessWidget {
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/main.png',
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      child: NextPrayer(),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'مواقيت الصلاة',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrayerTimeWidget(
                    prayerDate: 'صباحا',
                    prayerName: 'الفجر',
                    prayerTime: '03:45',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrayerTimeWidget(
                    prayerDate: 'ظهرا',
                    prayerName: 'الظهر',
                    prayerTime: '12:15',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrayerTimeWidget(
                    prayerDate: 'مساءا',
                    prayerName: 'العصر',
                    prayerTime: '03:30',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrayerTimeWidget(
                    prayerDate: 'مساءا',
                    prayerName: 'المغرب',
                    prayerTime: '07:00',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PrayerTimeWidget(
                    prayerDate: 'مساءا',
                    prayerName: 'العشاء',
                    prayerTime: '08:05',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
