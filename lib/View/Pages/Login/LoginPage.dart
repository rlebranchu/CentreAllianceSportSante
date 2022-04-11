import 'package:centre_alliance_sport_sante/Controllers/AuthController.dart';
import 'package:centre_alliance_sport_sante/View/Widgets/TextFormFieldApp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends Page {
  // Function use on Login's button
  final VoidCallback onLogin;

  // onLogin : REQUIRED -> Function executed when the button Login is pressed
  const LoginPage({required this.onLogin})
      : super(key: const ValueKey('LoginPage'));

  @override
  Route createRoute(BuildContext context) {
    // Creation of the Route which show the Login Page
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => LoginScreen(onLogin: onLogin),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginScreen({Key? key, required this.onLogin}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initialisation of state values (just to skip input of login informations)
  String _email = '';
  String _password = '';

  // Context use later for Loading Dialog
  late BuildContext loginDialogContext;

  // Function to show Dialog of loading of connexion
  showLoaderDialog(BuildContext context) {
    // Definition of Dialog
    Dialog _dialog = Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                //Loader
                CircularProgressIndicator(
                  color: Colors.orange,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Tentative de connexion"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Native Function to show un Dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        loginDialogContext = context;
        return _dialog;
      },
    );
  }

  onSignInPressed() async {
    // Ask to show Dialog
    showLoaderDialog(context);
    final authController = context.read<AuthController>();
    final result = await authController.login(_email, _password);
    // Hide Dialog of loading
    Navigator.pop(loginDialogContext);
    if (result == true) {
      widget.onLogin();
    } else {
      authController.logingIn = false;
    }
  }

  // Definition of the Login page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Scrolling auto-generate when view is reduce (for keyboard in this situation)
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
                    child: Image.asset('assets/images/CASS_Logo.png'),
                  ),
                  Text('CONNEXION',
                      style: Theme.of(context).textTheme.headline1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextFormFieldApp(
                            label: 'Identifiant',
                            onChange: (text) {
                              setState(() => _email = text);
                            },
                            initialValue: _email,
                            icon: Icons.person),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: TextFormFieldApp(
                              label: 'Mot de passe',
                              onChange: (text) {
                                setState(() => _password = text);
                              },
                              initialValue: _password,
                              icon: Icons.lock,
                              obscureText: true,
                              enableSuggestions: false),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: ElevatedButton(
                            onPressed: onSignInPressed,
                            child: const Text('SE CONNECTER'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
