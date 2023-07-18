import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String nome;
  String email;
  String type;

  UserData({
    required this.nome,
    required this.email,
    required this.type,
  });

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}
