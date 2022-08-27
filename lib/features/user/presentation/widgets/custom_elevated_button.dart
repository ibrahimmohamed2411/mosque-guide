import 'package:flutter/material.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';

import '../../../../core/utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const CustomElevatedButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? AppColors.hint,
          elevation: 500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: labelStyle ?? Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
