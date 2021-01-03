import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const AdaptiveButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            color: Theme.of(context).primaryColor,
            child: Text(label),
            onPressed: onPressed,
          )
        : RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            child: Text(label),
            onPressed: onPressed,
          );
  }
}
