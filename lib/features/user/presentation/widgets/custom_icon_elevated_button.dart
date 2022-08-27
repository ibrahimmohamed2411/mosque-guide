import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';

class CustomIconElevatedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  const CustomIconElevatedButton({
    Key? key,
    required this.icon,
    required this.label,
    this.borderColor,
    this.backgroundColor,
    this.iconColor,
    this.labelColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: context.width,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          elevation: 500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1,
            ),
          ),
        ),
        onPressed: onPressed,
        icon: FaIcon(
          icon,
          color: iconColor,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
