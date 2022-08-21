import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final GestureTapCallback? onTap;
  const CustomListTile({
    Key? key,
    this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      leading: leading,
      minLeadingWidth: 0,
      onTap: onTap,
    );
  }
}
