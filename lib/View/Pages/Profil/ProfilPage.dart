import 'package:flutter/material.dart';

class ProfilPage extends Page {
  const ProfilPage() : super(key: const ValueKey('ProfilPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => const ProfilScreen(),
    );
  }
}

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  child: Image.asset('assets/images/CASS_Logo.png'),
                ),
                Text('PROFIL PAGE',
                    style: Theme.of(context).textTheme.headline1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
