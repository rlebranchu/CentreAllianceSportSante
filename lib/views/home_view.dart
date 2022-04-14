import 'package:centre_alliance_sport_sante/views/widgets/session_list_item.dart';
import 'package:centre_alliance_sport_sante/views/widgets/title_section.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CENTRE ALLIANCE SPORT SANTE'),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: null, //onSignOutPressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(children: <Widget>[
          Text('Bienvenue', style: Theme.of(context).textTheme.headline1),
          const TitleSection(title: 'Mes prochaines séances'),
          SizedBox(
            height: 80.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10.0),
              itemCount: 8,
              itemBuilder: (context, index) => const SessionListItem(),
            ),
          ),
        ]),
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
