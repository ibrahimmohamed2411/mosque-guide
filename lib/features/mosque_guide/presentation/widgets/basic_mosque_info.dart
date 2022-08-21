import 'package:flutter/material.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';

import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';
import 'mosque_info.dart';
class BasicMosqueInfo extends StatelessWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  const BasicMosqueInfo({
    Key? key,
    required this.mosque,
    required this.placeDirections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 9),
      height: 150,
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 3,
            thickness: 6,
            indent: 160,
            endIndent: 160,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/marker_icon.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
              Expanded(
                child: MyWidget(
                  icon: Icons.place,
                  subtitle: 'المسافة',
                  title: placeDirections.totalDistance,
                ),
              ),
              Expanded(
                child: MyWidget(
                  icon: Icons.timer,
                  subtitle: 'الوقت المتوقع',
                  title: placeDirections.totalDuration,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('مسجد ${mosque.name}'),
              Text(mosque.street),
            ],
          ),
        ],
      ),
    );
  }
}
