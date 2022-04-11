// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:centre_alliance_sport_sante/Controllers/AuthController.dart';
import 'package:centre_alliance_sport_sante/Controllers/HomeController.dart';
import 'package:centre_alliance_sport_sante/Repository/HomeRepository.dart';
import 'package:centre_alliance_sport_sante/Services/AuthService.dart';
import 'package:centre_alliance_sport_sante/Services/UserService.dart';
import 'package:centre_alliance_sport_sante/Utility/SharedPreferencesUtility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import Configurations
import 'Configuration/Router/AppRouterDelegate.dart';
import 'Configuration/Theme/AppTheme.dart';

//Import Repositories
import 'Repository/AuthRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Cache Gestion : Only for Authentification at moment
  late AppRouterDelegate delegate;
  late SharedPreferencesUtility preferencesUtility;
  late AuthService authService;
  late UserService userService;
  late AuthRepository authRepository;
  late HomeRepository homeRepository;

  @override
  void initState() {
    super.initState();
    //Initialize SharedPreferences
    preferencesUtility = SharedPreferencesUtility(preferences: SharedPreferences.getInstance());
    //Initialize User Service
    userService = UserService();
    // Initialize auth state by cache
    authService = AuthService();
    authRepository = AuthRepository(preferencesUtility, authService, userService);
    homeRepository = HomeRepository(preferencesUtility);

    // Set application first page showed on auth condition
    delegate = AppRouterDelegate(authRepository, homeRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider on evolution of auth state to change page ([Idea for futur dev] and deconnection by expired token)
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(authRepository),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(homeRepository),
        ),
      ],
      // Genaral App : use Material
      child: MaterialApp(
        // Theme of application : like style.css in web (theme imported from another file : Configuration/Theme/AppTheme.dart)
        theme: AppTheme().Theme,
        title: 'Center Alliance Sport',
        // Navigation of App use native Router in Flutter
        home: Router(
          routerDelegate: delegate,
          // Function use on back button
          backButtonDispatcher: RootBackButtonDispatcher(),
        )
      ),
    );
  }
}