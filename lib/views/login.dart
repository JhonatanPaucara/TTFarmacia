import 'package:flutter/material.dart';
import 'package:ttfarmacia/utils/background.dart';
import 'package:ttfarmacia/models/basic.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<User> users = [];
  var user = {'mail': '', 'password': ''};
  bool _hidePass = true;
  _verifyUser(User usuario) {
    bool validUser = false;
    print(usuario.mail);
    print(usuario.password);
    for (var user in users) {
      print(user.mail);
      print(user.password);
      if (usuario.mail == user.mail && usuario.password == user.password) {
        print('Es el usuario ${usuario.mail}');
        validUser = true;
        Navigator.pushNamed(context, 'home');
        break;
      }
    }
    if (!validUser) print('No existe el usuario');
  }

  @override
  Widget build(BuildContext context) {
    users.add(User(mail: 'user1', password: 'clave1'));
    users.add(User(mail: 'user2', password: 'clave2'));
    users.add(User(mail: 'user3', password: 'clave3'));
    users.add(User(mail: 'user4', password: 'clave4'));
    users.add(User(mail: 'user5', password: 'clave5'));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          background(context),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_circle, color: Colors.red),
                        labelText: 'Correo Electrónico'),
                    onChanged: (value) {
                      setState(() {
                        user['mail'] = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    obscuringCharacter: '*',
                    obscureText: _hidePass,
                    decoration: InputDecoration(
                        icon: Icon(Icons.account_balance_wallet,
                            color: Colors.yellow),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _hidePass ? Icons.visibility : Icons.visibility_off,
                            size: 20,
                          ),
                          onPressed: () {
                            _hidePass = !_hidePass;
                            setState(() {});
                          },
                        ),
                        labelText: 'Contraseña'),
                    onChanged: (value) {
                      setState(() {
                        user['password'] = value;
                      });
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _verifyUser(
                        User(mail: user['mail'], password: user['password']));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.orange,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
