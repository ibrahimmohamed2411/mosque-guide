// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsLoadingState extends ContactUsState {}

class ContactUsErrorState extends ContactUsState {
  final String msg;
  ContactUsErrorState({
    required this.msg,
  });
    @override
  List<Object> get props => [msg];
}

class ContactUsSuccessState extends ContactUsState {}
