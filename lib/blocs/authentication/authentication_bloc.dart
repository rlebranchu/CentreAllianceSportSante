import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<Future<User>>? _userSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(
                authenticationRepository.currentUser)
            : const AuthenticationState.unauthenticated()) {
    on<AuthenticationUserChanged>(_onUserChanged);
    on<AuthenticationLogoutRequested>(_onLogoutRequested);

    _userSubscription = _authenticationRepository.user.listen(
      (user) async => add(AuthenticationUserChanged(await user)),
    );
  }

  void _onUserChanged(
      AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : AuthenticationState.unauthenticated());
  }

  void _onLogoutRequested(
      AuthenticationLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(_authenticationRepository.logOut());
    emit(AuthenticationState.unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
