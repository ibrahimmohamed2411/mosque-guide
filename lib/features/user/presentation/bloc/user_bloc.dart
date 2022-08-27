import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mosque_guide/core/usecases/usecase.dart';
import 'package:mosque_guide/features/user/domain/usecases/sign_in_with_google_uservase.dart';

import '../../domain/usecases/sign_in_anonymously_usecase.dart';
import '../../domain/usecases/sign_in_with_facebook_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithFacebookUsecase signInWithFacebookUseCase;
  final SignInAnonymouslyUseCase signInAnonymouslyUseCase;
  UserBloc({
    required this.signInWithGoogleUseCase,
    required this.signInAnonymouslyUseCase,
    required this.signInWithFacebookUseCase,
  }) : super(UserInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(SignInLoadingState());
      final signInSuccessOrFailure = await signInWithGoogleUseCase(NoParams());
      signInSuccessOrFailure.fold(
        (failure) => emit(SignInErrorState('sign in failure')),
        (unit) => emit(SignInSuccessState()),
      );
    });
    on<SignInWithFacebookEvent>((event, emit) async {
      emit(SignInLoadingState());
      final signInSuccessOrFailure = await signInWithFacebookUseCase(NoParams());
      signInSuccessOrFailure.fold(
        (failure) => emit(SignInErrorState('sign in failure')),
        (unit) => emit(SignInSuccessState()),
      );
    });
    on<SignInAnonymouslyEvent>((event, emit) async {
      emit(SignInLoadingState());
      final signInSuccessOrFailure = await signInAnonymouslyUseCase(NoParams());
      signInSuccessOrFailure.fold(
        (failure) => emit(SignInErrorState('sign in failure')),
        (unit) => emit(SignInSuccessState()),
      );
    });
  }
}
