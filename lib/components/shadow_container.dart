import 'package:firebase_credentials_flutter/model_providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShadowContainer extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  const ShadowContainer({this.margin, this.padding, this.child, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: padding ?? EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: themeProvider.isLightTheme
            ? [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(.15), spreadRadius: 0, offset: Offset(0, 1))]
            : [],
      ),
      child: child,
    );
  }
}
