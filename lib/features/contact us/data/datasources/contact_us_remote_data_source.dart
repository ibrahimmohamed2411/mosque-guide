import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ContactUsRemoteDataSource {
  Future<Unit> sendMessage(String message);
}

class ContactUsRemoteDataSourceImp implements ContactUsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  ContactUsRemoteDataSourceImp({
    required this.firestore,
    required this.firebaseAuth,
  });
  @override
  Future<Unit> sendMessage(String message) async {
    await firestore.collection('messages').add({
      'message': message,
    });
    return Future.value(unit);
  }
}
