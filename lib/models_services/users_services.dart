import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_credentials_flutter/model/user.dart';

class UsersService {
  static Future<Stream<List<User>>> streamUsers() async {
    var ref = Firestore.instance.collection('users');

    return ref.snapshots().map((list) => list.documents.map((doc) => User.fromFirestore(doc)).toList());
  }

  static Future updateUser({
    User user,
    bool isRegistering,
  }) async {
    if (isRegistering) {
      await Firestore.instance.collection('users_registrations').add(
        {
          'email': user.email,
          'isAdmin': false,
          'name': user.name,
          'password': user.password,
        },
      );
    } else {
      await Firestore.instance.collection('users').document(user.documentID).setData({
        'email': user.email,
        'isAdmin': user.isAdmin,
        'name': user.name,
      }, merge: true);
    }
  }

  static Future updateUserPassword({
    User user,
  }) async {
    await Firestore.instance.collection('users_update_password').add(
      {
        'password': user.password,
        'userUid': user.documentID,
      },
    );
  }
}
