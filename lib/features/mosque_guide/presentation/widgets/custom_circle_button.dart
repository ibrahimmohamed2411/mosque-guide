import 'package:flutter/material.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';

class CustomCircleButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Icon icon;
  final double elevation;
  const CustomCircleButton(
      {Key? key,
      this.onPressed,
      required this.icon,
      this.elevation = 0.0,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.white,
      width: context.width,
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: elevation,
        fillColor: backgroundColor,
        child: icon,
        padding: EdgeInsets.all(12.0),
        shape: CircleBorder(),
      ),
    );
  }
}
