import 'package:flutter/material.dart';

class PrimaryAppBarWithText extends StatelessWidget
    implements PreferredSizeWidget {
  PrimaryAppBarWithText(this.text,
      {this.showBackButton = false, this.showCartIcon = false});

  final String text;
  final bool showBackButton;
  final bool showCartIcon;

  @override
  final Size preferredSize = Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        brightness: Brightness.dark,
        elevation: 1,
        title: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: showBackButton
            ? BackButton(
                color: Colors.white,
              )
            : Container(),
      ),
    );
  }
}
