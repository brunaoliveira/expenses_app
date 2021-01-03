import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool autofocus;
  final Function(String) onSubmited;

  AdaptiveTextField({
    this.label,
    this.keyboard,
    this.controller,
    this.autofocus,
    this.onSubmited,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              padding: EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 12,
              ),
              placeholder: label,
              controller: controller,
              keyboardType: keyboard,
              autofocus: autofocus,
              cursorColor: Theme.of(context).primaryColor,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: onSubmited,
            ),
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
            ),
            keyboardType: keyboard,
            autofocus: autofocus,
            cursorColor: Theme.of(context).primaryColor,
            textCapitalization: TextCapitalization.sentences,
            onSubmitted: onSubmited,
          );
  }
}
