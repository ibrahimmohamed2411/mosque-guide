import 'package:flutter/material.dart';
class PrayerTimeWidget extends StatelessWidget {
  final String prayerName;
  final String prayerTime;
  final String prayerDate;
  const PrayerTimeWidget({
    Key? key,
    required this.prayerName,
    required this.prayerTime,
    required this.prayerDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/main.png',
          ),
          SizedBox(
            width: 13,
          ),
          Text(
            prayerName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Spacer(),
          Text(
            prayerTime,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            prayerDate,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
