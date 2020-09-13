import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttfarmacia/src/bloc/register/bloc.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ttfarmacia/src/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserUtils _userUtils;
  RegisterBloc({@required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
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
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is Submitted) {
      yield* _mapSubmittedToState(
        event.email,
        event.password,
      );
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isPasswordEmail(password));
  }

  Stream<RegisterState> _mapSubmittedToState(
      String email, String password) async* {
    yield RegisterState.loading();
    try {
      await _userUtils.signUp(email, password);
      yield RegisterState.success();
    } catch (e) {
      yield RegisterState.failure();
    }
  }
}
