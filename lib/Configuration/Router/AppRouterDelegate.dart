import 'package:flutter/material.dart';

// Import Configuration
import 'AppConfiguration.dart';

// Import Repositories
import '../../Repository/Auth/AuthRepository.dart';

// Import Pages
import '../../View/Pages/Splash/SplashPage.dart';
import '../../View/Pages/Home/HomePage.dart';
import '../../View/Pages/Login/LoginPage.dart';

class AppRouterDelegate extends RouterDelegate<AppConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfiguration> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AuthRepository authRepository;

  // Initialisation of Router State
  _init() async {
    loggedIn = await authRepository.isUserLoggedIn();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  AppRouterDelegate(this.authRepository) {
    _init();
  }

  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    _loggedIn = value;
    // Notify providers for each modifications of log state
    notifyListeners();
  }

  // Function each return AppConfiguration according to log state
  @override
  AppConfiguration? get currentConfiguration {
    if (loggedIn == null) {
      return AppConfiguration.splash();
    } else if (loggedIn == false) {
      return AppConfiguration.login();
    } else if (loggedIn == true) {
      return AppConfiguration.home();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Page> stack;
    final loggedIn = this.loggedIn;

    // Selection of the Page to show according to log state
    if (loggedIn == null) {
      stack = _splashStack;
    } else if (loggedIn == true) {
      stack = _loggedInStack;
    } else {
      stack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: stack,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  // Showing Splash Page with Message in param
  List<Page> get _splashStack {
    String? process;
    if (loggedIn == null) {
      process = null;
    } else {
      process = "Chargement...";
    }
    return [
      SplashPage(process: process),
    ];
  }

  // Showing Login Page with function login in param
  List<Page> get _loggedOutStack => [
        LoginPage(
          onLogin: () async {
            loggedIn = true;
          },
        ),
      ];

  // Showing Home Page with function login in param
  List<Page> get _loggedInStack => [
        HomePage(
          onLogout: () async {
            loggedIn = false;
          },
        ),
      ];

  // Function use when logout
  // but not use now because nothing is needed to clear currently
  _clear() {}

  @override
  Future<void> setNewRoutePath(AppConfiguration configuration) async {}
}
