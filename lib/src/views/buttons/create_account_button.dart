import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final VoidCallback _onPressed;

  CreateAccountButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: _onPressed,
      child: Text('Crear cuenta'),
    );
  }
}
