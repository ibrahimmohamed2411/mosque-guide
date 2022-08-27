import 'package:shared_preferences/shared_preferences.dart';

abstract class OnBoardingLocalDataSource {
  Future<void> cacheOnBoardingState();
  Future<String?> getOnBoardingState();
}

const String ONBOARDINGSTATE = 'on_boarding_state';
const String OPENEDBEFORE = 'openedBefore';

class OnBoardingLocalDataSourceImp implements OnBoardingLocalDataSource {
  final SharedPreferences sharedPreferences;
  OnBoardingLocalDataSourceImp({
    required this.sharedPreferences,
  });
  @override
  Future<void> cacheOnBoardingState() async {
    await sharedPreferences.setString(ONBOARDINGSTATE, OPENEDBEFORE);
  }

  @override
  Future<String?> getOnBoardingState() async{
    return sharedPreferences.getString(ONBOARDINGSTATE);
  }
}
