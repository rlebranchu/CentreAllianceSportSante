part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Session> listSession;
  final bool isLoading;

  const HomeLoaded({required this.listSession, this.isLoading = false});

  const HomeLoaded.startSearchListSession()
      : this(
          listSession: const <Session>[],
          isLoading: true,
        );

  const HomeLoaded.setListSession(List<Session> listSession)
      : this(listSession: listSession, isLoading: false);

  @override
  List<Object> get props => [listSession, isLoading];
}
