import 'package:centre_alliance_sport_sante/blocs/app/app_bloc.dart';
import 'package:centre_alliance_sport_sante/views/views.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeView.page()];
    case AppStatus.unauthenticated:
      return [LoginView.page()];
  }
}
