import 'package:flutter/material.dart';

import '../../domain/entities/mosque.dart';
import '../../domain/entities/place_directions.dart';
import 'basic_mosque_info.dart';
import 'mosque_info.dart';
class CustomAnimatedWidget extends StatefulWidget {
  final Mosque mosque;
  final PlaceDirections placeDirections;
  const CustomAnimatedWidget(
      {Key? key, required this.mosque, required this.placeDirections})
      : super(key: key);

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget> {
  bool firstWidget = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: GestureDetector(
        onTap: () {
          setState(() {
            firstWidget = false;
          });
        },
        child: BasicMosqueInfo(
          mosque: widget.mosque,
          placeDirections: widget.placeDirections,
        ),
      ),
      secondChild: GestureDetector(
        onTap: () {
          setState(() {
            firstWidget = true;
          });
        },
        child: MosqueInfo(
          mosque: widget.mosque,
        ),
      ),
      crossFadeState:
          firstWidget ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 500),
      sizeCurve: Curves.easeInOut,
    );
  }
}
