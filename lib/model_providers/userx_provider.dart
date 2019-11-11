import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appUtils/get_it.dart';
import '../appUtils/navigator.dart';
import '../model/user.dart';
import '../models_services/userx_service.dart';

class UserxProvider with ChangeNotifier {
  final Firestore firestore = Firestore.instance;

  bool pushRoutes = true;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;

  bool _signinError = false;
  bool get signinError => _signinError;

  User _userx;
  User get userx => _userx;

  bool _shouldContinue = true;

  Future<bool> initStateLogin() async {
    _userx = await UserxService.getUserx();

    if (_userx == null) {
      locator<NavigationService>().navigateTo('/sign_in_page');
      pushRoutes = true;
      _shouldContinue = false;
    }

    return _shouldContinue;
  }

  Future initStateStartApp() async {
    _userx = await UserxService.getUserx();

    if (_userx != null) {
      var streamUser = await UserxService.streamUserx();
      streamUser.listen(
        (res) {
          if (res != null && pushRoutes) {
            locator<NavigationService>().navigateTo('/users_dashboard_page');
            pushRoutes = false;
          }
          if (res == null) {
            locator<NavigationService>().navigateTo('/splash_screen_page');
            pushRoutes = true;
          }
          notifyListeners();
        },
      );
    }

    FirebaseAuth.instance.onAuthStateChanged.listen((res) {
      if (res == null) {
        locator<NavigationService>().navigateTo('/sign_in_page');
        pushRoutes = true;
      }
    });
  }

  Future<bool> signInWithEmailAndPassword({@required String email, @required String password}) async {
    _signinError = false;
    _isSigningIn = true;
    notifyListeners();

    email.trim().toLowerCase();

    bool shouldContinue = await UserxService.signInWithEmailAndPaddword(email: email, password: password);

    _isSigningIn = false;
    if (!shouldContinue) _signinError = true;
    notifyListeners();

    return shouldContinue;
  }

  Future signOut() async {
    await UserxService.signOut();
  }
}
