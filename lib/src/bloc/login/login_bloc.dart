import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttfarmacia/src/bloc/login/bloc.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ttfarmacia/src/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserUtils _userUtils;

  LoginBloc({@required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils;

  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 500));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isPasswordEmail(password));
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _userUtils.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
      print('Error while login with google');
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      await _userUtils.signInWithCredential(email.trim(), password.trim());
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
      print('Error while login with credentials');
    }
  }
}
