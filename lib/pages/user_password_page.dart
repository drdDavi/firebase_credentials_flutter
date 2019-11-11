import 'package:firebase_credentials_flutter/components/flat_button_custom.dart';
import 'package:firebase_credentials_flutter/components/page_header.dart';
import 'package:firebase_credentials_flutter/components/text_form_field_validation.dart';
import 'package:firebase_credentials_flutter/model/user.dart';
import 'package:firebase_credentials_flutter/model_providers/theme_provider.dart';
import 'package:firebase_credentials_flutter/model_providers/users_provider.dart';
import 'package:firebase_credentials_flutter/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class UserPasswordPage extends StatefulWidget {
  final User user;
  UserPasswordPage({this.user, Key key}) : super(key: key);

  @override
  _UserPasswordPageState createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {
  User user;
  @override
  void initState() {
    user = widget.user;
    user.password = '';
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesome.getIconData("lightbulb-o")),
            onPressed: () {
              themeProvider.setThemeData = !themeProvider.isLightTheme;
            },
          ),
          IconButton(
            icon: Icon(AntDesign.getIconData("logout")),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SignInPage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            PageHeader(
              title: 'Change Password',
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text('${user.name}'),
            ),
            SizedBox(height: 10),
            TextFormFieldValidation(
              hint: 'Password',
              initialValue: user.password,
              onValueChanged: (val) {
                user.password = val;
              },
            ),
            SizedBox(height: 10),
            FlatButtonCustom(
              title: 'SUBMIT',
              color: Theme.of(context).buttonColor,
              onTap: () {
                if (formKey.currentState.validate()) {
                  usersProvider.updateUserPassword(user: user);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
