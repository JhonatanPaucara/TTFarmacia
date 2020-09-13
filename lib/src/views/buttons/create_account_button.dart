import 'package:flutter/material.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';

class CreateAccountButton extends StatelessWidget {
  final UserUtils _userUtils;

  CreateAccountButton({Key key, @required userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        Navigator.of(context).pushNamed('register', arguments: _userUtils);
      },
      child: Text('Crear cuenta'),
    );
  }
}
