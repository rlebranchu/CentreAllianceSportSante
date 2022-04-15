import 'package:centre_alliance_sport_sante/cubits/cubits.dart';
import 'package:centre_alliance_sport_sante/repositories/authentication_repository.dart';
import 'package:centre_alliance_sport_sante/views/widgets/textformfield_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Scrolling auto-generate when view is reduce (for keyboard in this situation)
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (_) => LoginCubit(
              context.read<AuthenticationRepository>(),
            ),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          //TODO : Do something if error
        }
      },
      child: Column(
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
                    child: _LogInButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormFieldApp(
            label: 'Identifiant',
            onChange: (email) {
              context.read<LoginCubit>().emailChanged(email);
            },
            icon: Icons.person);
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormFieldApp(
            label: 'Mot de passe',
            onChange: (password) {
              context.read<LoginCubit>().passwordChanged(password);
            },
            icon: Icons.lock,
            obscureText: true,
            enableSuggestions: false);
      },
    );
  }
}

class _LogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logInWithCredentials();
                },
                child: const Text('SE CONNECTER'),
              );
      },
    );
  }
}
