import 'package:flutter/material.dart';
import 'package:ttfarmacia/src/utils/background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';
import 'package:ttfarmacia/src/bloc/login/bloc.dart';
import 'package:ttfarmacia/src/bloc/auth/bloc.dart';
import 'package:ttfarmacia/src/views/buttons/create_account_button.dart';
import 'package:ttfarmacia/src/views/buttons/google_login_button.dart';
import 'package:ttfarmacia/src/views/buttons/login_button.dart';

class Login extends StatelessWidget {
  Login({Key key, this.title, @required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils,
        super(key: key);

  final String title;
  final UserUtils _userUtils;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider(
        create: (context) => LoginBloc(userUtils: _userUtils),
        child: LoginForm(
          userUtils: _userUtils,
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key, @required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils,
        super(key: key);

  final UserUtils _userUtils;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserUtils get _userUtils => widget._userUtils;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _emailController.addListener(_onPasswordChanged);
  }

  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login Failure'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Loggin in... '), CircularProgressIndicator()],
              ),
              backgroundColor: Colors.green,
            ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            children: [
              background(context),
              Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'INICIAR SESIÓN',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            icon: Icon(Icons.account_circle, color: Colors.red),
                            labelText: 'Correo Electrónico'),
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isEmailValid ? 'Invalid Email' : null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.red),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hidePass
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                              ),
                              onPressed: () {
                                _hidePass = !_hidePass;
                                setState(() {});
                              },
                            ),
                            labelText: 'Contraseña'),
                        autovalidate: true,
                        autocorrect: false,
                        obscureText: _hidePass,
                        validator: (_) {
                          return !state.isPasswordValid
                              ? 'Invalid Password'
                              : null;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LoginButton(
                            onPressed: isLoginButtonEnabled(state)
                                ? _onFormSubmitted
                                : null,
                          ),
                          GoogleLoginButton(
                            onPressed: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Loggin in ...'),
                                    CircularProgressIndicator()
                                  ],
                                ),
                              ));
                              _loginBloc.add(LoginWithGooglePressed());
                            },
                          ),
                          CreateAccountButton(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    print('INICIANDO SESIÓN');
    print('email: ${_emailController.text}');
    print('password: ${_passwordController.text}');
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }
}
