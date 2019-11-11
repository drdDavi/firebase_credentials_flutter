import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String documentID;
  String email;
  String name;
  String password;

  bool isAdmin;

  User({
    this.documentID,
    this.email,
    this.isAdmin,
    this.name,
    this.password,
  });

  factory User.fromFirestore(DocumentSnapshot document) {
    Map data = document.data;

    return User(
      documentID: document.documentID,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
  }
}
