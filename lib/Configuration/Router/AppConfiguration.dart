class AppConfiguration {
  final bool? loggedIn;

  //Function return AppConfiguation with loggedIn Attribut setted to null
  // Use on start of the application (SplashPage showed)
  AppConfiguration.splash()
      : loggedIn = null;

  //Function return AppConfiguation with loggedIn Attribut setted to false
  // Use when user not logged (LoginPage showed)
  AppConfiguration.login()
      : loggedIn = false;

  //Function return AppConfiguation with loggedIn Attribut setted to true
  // Use when user not logged (HomePage showed)
  AppConfiguration.home()
      : loggedIn = true;

  // Getter to check the differents log's situations
  bool get isHomePage => loggedIn == true;
  bool get isLoginPage => loggedIn == false;
  bool get isSplashPage => loggedIn == null;
}