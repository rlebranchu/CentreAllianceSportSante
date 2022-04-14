// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:centre_alliance_sport_sante/bloc_observer.dart';
import 'package:centre_alliance_sport_sante/blocs/app/app_bloc.dart';
import 'package:centre_alliance_sport_sante/config/app_theme.dart';
import 'package:centre_alliance_sport_sante/config/routes.dart';
import 'package:centre_alliance_sport_sante/firebase_options.dart';
import 'package:centre_alliance_sport_sante/repositories/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    runApp(App(authenticationRepository: authenticationRepository));
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository;

  const App(
      {Key? key, required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
            child: const AppView()));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme().Theme,
      title: 'Center Alliance Sport',
      home: FlowBuilder(
          state: context.select((AppBloc bloc) => bloc.state.status),
          onGeneratePages: onGenerateAppViewPages),
    );
  }
}
