import 'package:flutter/material.dart';

class SplashPage extends Page {
  // Message to Show under App Logo
  final String? process;

  // process : REQUIRED -> Message to show in Splash Screen (nullable)
  SplashPage({required this.process})
      : super(key: ValueKey('SplashPage$process'));

  @override
  Route createRoute(BuildContext context) {
    // Creation of the Route which show the Splash Page
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return SplashScreen(process: process);
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  final String? process;

  const SplashScreen({Key? key, this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                child: Image.asset('assets/images/CASS_Logo.png'),
              ),
              // Not show splash Text if nothing to show
              if (process != null) Text(process ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
