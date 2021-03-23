import 'package:cheapest_app/utilities/constants/theme_globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Icon icon;
  final double size;

  CustomButton({
    this.title,
    this.onTap,
    this.color,
    this.icon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color ?? primaryColor,
      onPressed: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: icon == null ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            icon ?? SizedBox.shrink(),
            title != null ? Text(title, style: bodyText2.copyWith(fontSize: size)) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
