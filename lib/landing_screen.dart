import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque_guide/features/mosque_guide/presentation/screens/home_screen.dart';
import 'package:mosque_guide/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:mosque_guide/features/user/presentation/screens/sign_in_screen.dart';

import 'features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'features/user/data/datasources/user_local_data_source.dart';
import 'inject_container.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: sl<UserLocalDataSource>().autoStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return OnBoardingStateWidget();
          }
          return SignInScreen();
        },
      ),
    );
  }
}

class OnBoardingStateWidget extends StatelessWidget {
  const OnBoardingStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: sl<OnBoardingLocalDataSource>().getOnBoardingState(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen();
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        return BlocProvider(
          create: (context) => sl<OnBoardingCubit>(),
          child: OnBoardingScreen(),
        );
      },
    );
  }
}
