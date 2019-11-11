import 'package:firebase_credentials_flutter/model_providers/theme_provider.dart';
import 'package:firebase_credentials_flutter/model_providers/users_provider.dart';
import 'package:firebase_credentials_flutter/model_providers/userx_provider.dart';
import 'package:firebase_credentials_flutter/pages/users_dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

import '../components/flat_button_custom.dart';
import '../components/page_header.dart';
import '../components/text_form_field_validation.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userxProvider = Provider.of<UserxProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesome.getIconData("lightbulb-o")),
            onPressed: () {
              themeProvider.setThemeData = !themeProvider.isLightTheme;
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            PageHeader(
              title: 'Sign in',
            ),
            TextFormFieldValidation(
              hint: 'Email',
              onValueChanged: (val) {
                email = val;
              },
              onSaved: (val) {
                email = val;
              },
            ),
            TextFormFieldValidation(
              hint: 'Password',
              onValueChanged: (val) {
                password = val;
              },
              onSaved: (val) {
                password = val;
              },
            ),
            SizedBox(height: 10),
            FlatButtonCustom(
              title: 'SIGN IN',
              color: Theme.of(context).buttonColor,
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  bool shouldContinue =
                      await Provider.of<UserxProvider>(context, listen: false).signInWithEmailAndPassword(email: email, password: password);
                  if (shouldContinue) await Provider.of<UserxProvider>(context, listen: false).initStateStartApp();
                  if (shouldContinue) await Provider.of<UsersProvider>(context, listen: false).initState();
                  if (shouldContinue)
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UsersDashboardPage();
                        },
                      ),
                    );
                }
              },
            ),
            SizedBox(height: 50),
            if (userxProvider.isSigningIn)
              Center(
                  child: LoadingBouncingGrid.square(
                backgroundColor: Theme.of(context).accentColor,
              )),
            if (userxProvider.signinError)
              Center(
                  child: Text(
                'Oops something went wrong, please try again',
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
          ],
        ),
      ),
    );
  }
}
