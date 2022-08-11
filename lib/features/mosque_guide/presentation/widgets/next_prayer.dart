import 'package:flutter/material.dart';
class NextPrayer extends StatelessWidget {
  const NextPrayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '05:15 AM',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'صلاة الفجر',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
