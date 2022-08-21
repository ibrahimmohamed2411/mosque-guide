import 'package:flutter/material.dart';
import 'package:mosque_guide/config/routes/app_routes.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/widgets/custom_circle_button.dart';

import '../widgets/on_boarding_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageNumber = 0;
  final _controller = PageController();
  List<Widget> _pages = [
    OnBoardingWidget(
      imagePath: 'assets/images/on_boarding_1.png',
      caption1: 'الوصول لاقرب مسجد',
      caption2: 'تقدر تستخدم التطبيق بكل سهولة و تعرف توصل  ',
    ),
    OnBoardingWidget(
      imagePath: 'assets/images/on_boarding_2.png',
      caption1: 'معرف مكان لمصلي السيدات ',
      caption2: 'تقدر تستخدم التطبيق بكل سهولة و تعرف توصل',
    ),
    OnBoardingWidget(
      imagePath: 'assets/images/on_boarding_3.png',
      caption1: 'لا تفوتك صلاة الجماعة ',
      caption2: 'تقدر تستخدم التطبيق بكل سهولة و تعرف توصل  ',
    ),
    OnBoardingWidget(
      imagePath: 'assets/images/on_boarding_4.png',
      caption1: 'اللحاق بصلاة الجمعة',
      caption2: 'تقدر تستخدم التطبيق بكل سهولة و تعرف توصل   ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView(
                  controller: _controller,
                  children: _pages,
                  onPageChanged: (pageNumber) {
                    this.pageNumber = pageNumber;
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(60),
                  child: CustomCircleButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      print('pageNumber: $pageNumber');
                      if (hasNextPage()) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOutCubicEmphasized,
                        );
                      } else {
                        Navigator.of(context).pushReplacementNamed(
                          AppRoutes.homeScreen,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasNextPage() {
    return pageNumber < _pages.length - 1;
  }
}
