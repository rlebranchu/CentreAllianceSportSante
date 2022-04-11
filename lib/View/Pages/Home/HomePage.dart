import 'package:centre_alliance_sport_sante/View/Widgets/SessionListItem.dart';
import 'package:centre_alliance_sport_sante/View/Widgets/TitleSection.dart';
import 'package:centre_alliance_sport_sante/Controllers/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends Page {
  // Function use on Logout's button
  final VoidCallback onLogout;
  final String username;

  // onLogout : REQUIRED -> Function executed when the button Logout is pressed
  const HomePage({
    required this.onLogout,
    required this.username
  }) : super(key: const ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    // Creation of the Route which show the Home Page
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(onLogout: onLogout, username: username),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onLogout;
  final String username;

  const HomeScreen({Key? key, required this.onLogout, required this.username}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  onSignOutPressed() async {
    final authController = context.read<AuthController>();
    final result = await authController.logout();
    if (result == true) {
      widget.onLogout();
    } else {
      authController.logingIn = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CENTRE ALLIANCE SPORT SANTE'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onSignOutPressed,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(children: <Widget>[
            Text('Bienvenue', style: Theme.of(context).textTheme.headline1),
            Text(widget.username, style: Theme.of(context).textTheme.headline2),
            TitleSection(title: 'Mes prochaines séances'),
            Container(
              height: 80.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10.0),
                itemCount: 8,
                itemBuilder: (context, index) => SessionListItem(),
              ),
            ),
          ]),
        ),
      ), // Navigation Bar for change Screen show (only show in HomePage = Log confirmed)
      /*bottomNavigationBar: BottomNavigationBar(
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
      ),*/
    );
  }
}
