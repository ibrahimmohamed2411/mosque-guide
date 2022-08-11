import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';
import 'package:mosque_guide/core/utils/media_query_values.dart';
import '../../domain/entities/mosque.dart';
import '../cubit/mosque_cubit.dart';

class MosqueInfo extends StatelessWidget {
  final Mosque mosque;

  MosqueInfo({
    Key? key,
    required this.mosque,
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
      padding: EdgeInsets.all(10),
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(
            height: 5,
            thickness: 6,
            indent: 160,
            endIndent: 160,
          ),
          Image.asset(
            'assets/images/marker_icon.png',
            height: 80,
            width: 200,
            fit: BoxFit.cover,
          ),
          Text(mosque.name),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/men.png'),
              SizedBox(
                width: 15,
              ),
              if (mosque.availableForWomen)
                Image.asset('assets/images/women.png'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<MosqueCubit, MosqueState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is DirectionsLoadedState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyWidget(
                      icon: Icons.place,
                      title: '${state.placeDirections.totalDistance}',
                      subtitle: 'المسافة ',
                      iconColor: AppColors.primary,
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    MyWidget(
                      icon: Icons.timer,
                      title: '${state.placeDirections.totalDuration}',
                      subtitle: 'الوقت المتوقع',
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
          Text(mosque.street),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 3,
            thickness: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyWidget(
                iconColor: AppColors.brightGreen,
                icon: Icons.mosque,
                subtitle: mosque.mosqueStatus,
                title: 'حالة المسجد',
              ),
              MyWidget(
                iconColor: AppColors.brightGreen,
                icon: Icons.mosque,
                subtitle: mosque.fridayPrayer,
                title: 'صلاة الجمعة',
              ),
              MyWidget(
                iconColor: AppColors.brightGreen,
                icon: Icons.mosque,
                subtitle: 'حلقات الدروس',
                title: mosque.lessonsCircles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final Color? iconColor;

  const MyWidget({
    Key? key,
    required this.icon,
    required this.subtitle,
    required this.title,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$title',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 35, 0),
            child: Text(
              '$subtitle',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
