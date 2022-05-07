part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadListSession extends HomeEvent {
  final User user;

  const LoadListSession(this.user);

  @override
  List<Object> get props => [user];
}

class ShowSessionDetails extends HomeEvent {
  final Session session;

  const ShowSessionDetails(this.session);

  @override
  List<Object> get props => [session];
}
