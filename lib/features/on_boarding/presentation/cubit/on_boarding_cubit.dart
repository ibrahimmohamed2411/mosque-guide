import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/on_boarding/domain/usecases/cache_on_boarding_state_usecase.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final CacheOnBoardingStateUseCase cacheOnBoardingStateUseCase;

  OnBoardingCubit({required this.cacheOnBoardingStateUseCase})
      : super(OnBoardingInitial());
  Future<void> cacheOnBoardingState() async {
    final successOrFailure = await cacheOnBoardingStateUseCase(NoParams());
    successOrFailure.fold(
      (l) => print('failure'),
      (r) => print('success'),
    );
  }
}
