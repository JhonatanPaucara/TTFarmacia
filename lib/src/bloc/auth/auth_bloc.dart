import 'package:meta/meta.dart';
import 'package:ttfarmacia/src/bloc/auth/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ttfarmacia/src/utils/user_utils.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserUtils _userUtils;

  AuthBloc({@required UserUtils userUtils})
      : assert(userUtils != null),
        _userUtils = userUtils;
  @override
  AuthState get initialState => Uninitialized();
  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userUtils.isSignedIn();
      if (isSignedIn) {
        final user = await _userUtils.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield Authenticated(await _userUtils.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userUtils.signOut();
  }
}
