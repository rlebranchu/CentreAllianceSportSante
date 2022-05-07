import 'package:centre_alliance_sport_sante/blocs/authentication/authentication_bloc.dart';
import 'package:centre_alliance_sport_sante/views/views.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(
  AuthenticationStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [HomeView.page()];
    case AuthenticationStatus.unauthenticated:
      return [LoginView.page()];
  }
}
