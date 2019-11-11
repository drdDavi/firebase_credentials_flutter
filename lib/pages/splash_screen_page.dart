import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

import '../model_providers/users_provider.dart';
import '../model_providers/userx_provider.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) async {
      bool shouldContinue = await Provider.of<UserxProvider>(context, listen: false).initStateLogin();
      if (shouldContinue) await Provider.of<UserxProvider>(context, listen: false).initStateStartApp();
      if (shouldContinue) await Provider.of<UsersProvider>(context, listen: false).initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: LoadingBouncingGrid.square(
            backgroundColor: Theme.of(context).accentColor,
          ))
        ],
      ),
    );
  }
}
