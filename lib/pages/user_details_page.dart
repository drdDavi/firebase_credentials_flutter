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

class UserDetailsPage extends StatefulWidget {
  final User user;
  UserDetailsPage({this.user, Key key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  User user;
  @override
  void initState() {
    if (widget.user == null) {
      user = User();
    } else {
      user = widget.user;
    }
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
              title: widget.user == null ? 'New User' : 'Update User',
            ),
            TextFormFieldValidation(
              hint: 'Name',
              initialValue: user.name,
              onValueChanged: (val) {
                user.name = val.trim();
              },
            ),
            TextFormFieldValidation(
              hint: 'Email',
              initialValue: user.email,
              onValueChanged: (val) {
                user.email = val.trim();
              },
            ),
            if (widget.user == null)
              TextFormFieldValidation(
                hint: 'Password',
                initialValue: user.password,
                onValueChanged: (val) {
                  user.password = val.trim();
                },
              ),
            SizedBox(height: 10),
            FlatButtonCustom(
              title: 'SUBMIT',
              color: Theme.of(context).buttonColor,
              onTap: () {
                if (formKey.currentState.validate()) {
                  usersProvider.updateUser(user: user, isRegistering: widget.user == null ? true : false);
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
