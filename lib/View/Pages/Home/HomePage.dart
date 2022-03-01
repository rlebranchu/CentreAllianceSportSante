import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import ViewModel
import '../../../ViewModels/Auth/AuthViewModel.dart';

class HomePage extends Page {
  // Function use on Logout's button
  final VoidCallback onLogout;

  // onLogout : REQUIRED -> Function executed when the button Logout is pressed
  const HomePage({
    required this.onLogout,
  }) : super(key: const ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    // Creation of the Route which show the Home Page
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(onLogout: onLogout),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const HomeScreen({Key? key, required this.onLogout}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CENTRE ALLIANCE SPORT SANTÉ'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                child: Image.asset('assets/images/CASS_Logo.png'),
              ),
              Text('HOME PAGE', style: Theme.of(context).textTheme.headline1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                    onPressed: () async {
                      final authViewModel = context.read<AuthViewModel>();
                      final result = await authViewModel.login();
                      if (result == true) {
                        widget.onLogout();
                      } else {
                        authViewModel.logingIn = false;
                      }
                    },
                    child: const Text('SE DÉCONNECTER')),
              ),
            ],
          ),
        ),
      ),
      // Navigation Bar for change Screen show (only show in HomePage = Log confirmed)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
            ),
            label: 'PROGRAMMES',
            activeIcon: Icon(
              Icons.fitness_center,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
            ),
            label: 'SÉANCES',
            activeIcon: Icon(
              Icons.calendar_today,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'PROFIL',
            activeIcon: Icon(
              Icons.account_circle_outlined,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
