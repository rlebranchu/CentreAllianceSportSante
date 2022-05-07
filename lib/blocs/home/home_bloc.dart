import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:centre_alliance_sport_sante/blocs/blocs.dart';
import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SessionRepository _sessionRepository;
  final AuthenticationBloc _authenticationBloc;
  late final StreamSubscription<AuthenticationState> _userSubscription;

  HomeBloc({
    required AuthenticationBloc authenticationBloc,
    required SessionRepository sessionRepository,
  })  : _authenticationBloc = authenticationBloc,
        _sessionRepository = sessionRepository,
        super(HomeInitial()) {
    on<LoadListSession>(_onLoadListSession);

    _userSubscription = _authenticationBloc.stream.listen(
      (state) => add(LoadListSession(User.empty)),
    );
  }

  void _onLoadListSession(
      LoadListSession event, Emitter<HomeState> emit) async {
    emit(const HomeLoaded.startSearchListSession());
    late final List<Session> listSession;
    listSession = await _sessionRepository.getListSessionsOfUser(
        userId: 'IHj18QWRAodq1ubuOw5D9Yj1Bf13');
    emit(HomeLoaded.setListSession(listSession));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
