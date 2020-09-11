import 'package:flutter/material.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  GoogleLoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: _onPressed,
      child: Text('Ingresar con google'),
    );
  }
}
