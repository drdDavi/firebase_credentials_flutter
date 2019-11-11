import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final double marginBottom;
  const PageHeader({
    @required this.title,
    this.marginBottom,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        SizedBox(height: marginBottom ?? 20),
      ],
    );
  }
}
