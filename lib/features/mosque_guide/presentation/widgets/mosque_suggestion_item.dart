import 'package:flutter/material.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';

import '../../domain/entities/mosque.dart';

class MosqueSuggestionItem extends StatelessWidget {
  final Mosque mosque;
  const MosqueSuggestionItem({
    Key? key,
    required this.mosque,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.mosque,
        color: AppColors.brightGreen,
        size: 23,
      ),
      title: Text(
        mosque.name,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.brightGreen,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
