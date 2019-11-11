import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

class UserxService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _firebase = Firestore.instance;

  static Future<Stream<User>> streamUserx() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var ref = Firestore.instance.collection('users').document(user.uid).snapshots().asBroadcastStream();

    return ref.map((snap) {
      if (snap.exists) {
        return User.fromFirestore(snap);
      } else {
        return null;
      }
    });
  }

/* ----------------- NOTE Get User i.e Stream<User> != User ----------------- */
  static Future<User> getUserx() async {
    FirebaseUser fbUser = await FirebaseAuth.instance.currentUser();
    User user;
    Stream<User> streamUser;
    if (fbUser != null) {
      streamUser = await streamUserx();
      streamUser = streamUser.take(1);
      await for (User i in streamUser) {
        if (i != null) {
          user = i;
        }
      }
    }
    return user;
  }

  static Future<bool> signInWithEmailAndPaddword({String email, String password}) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult?.user;

      if (firebaseUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
    return;
  }
}
