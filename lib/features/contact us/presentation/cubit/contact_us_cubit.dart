import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mosque_guide/features/contact%20us/domain/usecases/send_message_usecase.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final SendMessageUseCase sendMessageUseCase;
  ContactUsCubit({required this.sendMessageUseCase})
      : super(ContactUsInitial());
  Future<void> sendMessage(String message) async {
    emit(ContactUsLoadingState());
    final successOrFailure = await sendMessageUseCase(message);
    emit(
      successOrFailure.fold(
        (failure) => ContactUsErrorState(msg: 'Error'),
        (unit) => ContactUsSuccessState(),
      ),
    );
  }
}
