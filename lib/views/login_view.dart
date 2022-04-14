import 'package:centre_alliance_sport_sante/views/widgets/textformfield_app.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginView());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        // Scrolling auto-generate when view is reduce (for keyboard in this situation)
        child: SingleChildScrollView(child: LoginForm()),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 20.0),
          child: Image.asset('assets/images/CASS_Logo.png'),
        ),
        Text('CONNEXION', style: Theme.of(context).textTheme.headline1),
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _EmailInput(),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: _PasswordInput()),
              Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: _LoginButton()),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldApp(
        label: 'Identifiant',
        onChange: () {}, // (text) {  setState(() => _email = text);},
        initialValue: '', // _email,
        icon: Icons.person);
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormFieldApp(
        label: 'Mot de passe',
        onChange: () {}, //(text) { setState(() => _password = text);},
        initialValue: '', //_password,
        icon: Icons.lock,
        obscureText: true,
        enableSuggestions: false);
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ElevatedButton(
      onPressed: null, //onSignInPressed,
      child: Text('SE CONNECTER'),
    );
  }
}
