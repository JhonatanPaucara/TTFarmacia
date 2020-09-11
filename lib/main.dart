import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttfarmacia/src/bloc/auth/bloc.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';
import 'package:ttfarmacia/src/views/login.dart';
import 'package:ttfarmacia/src/views/home.dart';
import 'package:ttfarmacia/src/views/pharmacy.dart';
import 'package:ttfarmacia/src/views/productGroup.dart';
import 'package:ttfarmacia/src/views/product.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserUtils userUtils = UserUtils();

  runApp(BlocProvider(
      create: (context) => AuthBloc(userUtils: userUtils)..add(AppStarted()),
      child: MyApp(userUtils: userUtils)));
}

class MyApp extends StatelessWidget {
  final UserUtils _userUtils;
  MyApp({Key key, @required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTFarmacia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'login': (BuildContext context) => Login(
              title: 'TTFarmacia_Login',
              userUtils: _userUtils,
            ),
        'home': (BuildContext context) => Home(title: 'TTFarmacia_Home'),
        'pharmacy': (BuildContext context) =>
            Pharmacy(title: 'TTFarmacia_Pharmacy'),
        'productGroup': (BuildContext context) =>
            ProductGroup(title: 'TTFarmacia_ProductGroup'),
        'product': (BuildContext context) =>
            Product(title: 'TTFarmacia_Product'),
      },
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Uninitialized) {
          return Container(
            child: Text('INICIALIZANDO'),
          );
        }
        if (state is Authenticated) {
          return Home(title: state.displayName);
        }
        if (state is Unauthenticated) {
          return Login(title: 'No autenticado', userUtils: _userUtils);
        }
        return Login(title: 'TTFarmacia null', userUtils: _userUtils);
      }),
    );
  }
}
