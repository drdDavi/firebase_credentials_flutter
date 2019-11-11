import 'package:firebase_credentials_flutter/components/shadow_container.dart';
import 'package:firebase_credentials_flutter/model/user.dart';
import 'package:firebase_credentials_flutter/model_providers/users_provider.dart';

import 'package:firebase_credentials_flutter/pages/user_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import '../components/page_header.dart';
import '../model_providers/theme_provider.dart';
import '../model_providers/userx_provider.dart';
import 'user_details_page.dart';

class UsersDashboardPage extends StatefulWidget {
  UsersDashboardPage({Key key}) : super(key: key);

  @override
  _UsersDashboardPageState createState() => _UsersDashboardPageState();
}

class _UsersDashboardPageState extends State<UsersDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userxProvider = Provider.of<UserxProvider>(context);
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
              userxProvider.signOut();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          PageHeader(
            title: 'Users Dashboard',
          ),
          for (int i = 0; i < usersProvider.users.length; i++)
            UserItem(
              user: usersProvider.users[i],
            ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return UserDetailsPage();
                    },
                    fullscreenDialog: true),
              );
            },
            icon: Icon(
              Icons.add,
            ),
            label: Text("User")),
      ),
    );
  }
}

class UserItem extends StatelessWidget {
  final User user;
  const UserItem({
    this.user,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(user.name),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(user.email),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return UserDetailsPage(
                                user: user,
                              );
                            },
                            fullscreenDialog: true),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration:
                          BoxDecoration(border: Border.all(color: Theme.of(context).buttonColor), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 10, color: Theme.of(context).buttonColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        new MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return UserPasswordPage(
                                user: user,
                              );
                            },
                            fullscreenDialog: true),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration:
                          BoxDecoration(border: Border.all(color: Theme.of(context).buttonColor), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 12, color: Theme.of(context).buttonColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
