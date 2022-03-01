import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import ViewModel
import '../../../ViewModels/Auth/AuthViewModel.dart';

class LoginPage extends Page {
  // Function use on Login's button
  final VoidCallback onLogin;

  // onLogin : REQUIRED -> Function executed when the button Login is pressed
  const LoginPage({required this.onLogin}) : super(key: const ValueKey('LoginPage'));

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
  String _username = 'robin.lebranchu@gmail.com';
  String _password = 'password';

  // Context use later for Loading Dialog
  late BuildContext loginDialogContext;

  // Function to show Dialog of loading of connexion
  showLoaderDialog(BuildContext context) {
    // Definition of Dialog
    Dialog _dialog = Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 175,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white
            ),
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
                        TextFormField(
                          initialValue: _username,
                          onChanged: (text) {
                            setState(() => _username = text);
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Identifiant',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: TextFormField(
                              initialValue: _password,
                              onChanged: (text) {
                                setState(() => _password = text);
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Mot de Passe',
                              ),
                              obscureText: true,
                              enableSuggestions: false),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // Ask to show Dialog
                              showLoaderDialog(context);
                              final authViewModel =
                                  context.read<AuthViewModel>();
                              final result = await authViewModel.login();
                              // Hide Dialog of loading
                              Navigator.pop(loginDialogContext);
                              if (result == true) {
                                widget.onLogin();
                              } else {
                                authViewModel.logingIn = false;
                              }
                            },
                            child: const Text('SE CONNECTER'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    // [Idea for future dev] : Generate a link for other Page to create an account
                    child: Text(
                      'Pas de compte ? Inscrivez-vous !',
                      style: Theme.of(context).textTheme.bodyText2,
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
