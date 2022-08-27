import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque_guide/core/utils/app_colors.dart';
import 'package:mosque_guide/features/user/presentation/bloc/user_bloc.dart';
import 'package:mosque_guide/features/user/presentation/widgets/custom_elevated_button.dart';
import 'package:mosque_guide/features/user/presentation/widgets/custom_icon_elevated_button.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is SignInSuccessState) {
                    print('Sign in success state');
                  } else if (state is SignInErrorState) {
                    print('Sign in error state');
                  } else if (state is SignInLoadingState) {
                    print('Sign in loading state');
                  }
                },
                child: SizedBox(),
              ),
              Text(
                'مرحبا بك في تطبيق دليل المساجد',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('من فضلك اختر طريقة التسجيل'),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomIconElevatedButton(
                      icon: Icons.facebook,
                      label: 'فيسبوك',
                      labelColor: Colors.white,
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context).add(
                          SignInWithFacebookEvent(),
                        );
                      },
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CustomIconElevatedButton(
                      icon: Icons.report_gmailerrorred,
                      label: 'جوجل',
                      labelColor: Colors.white,
                      onPressed: () async {
                        BlocProvider.of<UserBloc>(context)
                            .add(SignInWithGoogleEvent());
                      },
                      backgroundColor: Colors.orange[900],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                backgroundColor: Colors.grey[300],
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(
                    SignInAnonymouslyEvent(),
                  );
                },
                label: 'الدخول بدون تسجيل',
                labelStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
