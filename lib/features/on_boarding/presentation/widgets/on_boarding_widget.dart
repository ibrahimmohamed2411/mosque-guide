import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
class OnBoardingWidget extends StatelessWidget {
  final String imagePath;
  final String caption1;
  final String caption2;
  const OnBoardingWidget({
    Key? key,
    required this.caption1,
    required this.caption2,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 60, 20, 0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption1,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  caption2,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
