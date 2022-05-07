import 'package:centre_alliance_sport_sante/blocs/blocs.dart';
import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/views/widgets/session_list_item.dart';
import 'package:centre_alliance_sport_sante/views/widgets/title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomeView());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CENTRE ALLIANCE SPORT SANTE'),
        actions: <Widget>[
          _LogOutButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _HomePageHeader(),
            _HomePageContent(),
          ],
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

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
      },
    );
  }
}

class _HomePageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Column(
      children: <Widget>[
        Text('Bienvenue', style: Theme.of(context).textTheme.headline1),
        Text(user.name, style: Theme.of(context).textTheme.headline5),
      ],
    );
  }
}

class _HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _HomePageSession(),
      ],
    );
  }
}

class _HomePageSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const TitleSection(title: 'Mes prochaines séances'),
        SizedBox(height: 80.0, child: _ListSession()),
      ],
    );
  }
}

class _ListSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial || (state is HomeLoaded && state.isLoading)) {
          return Row(children: <Widget>[
            _SkeletonSession(),
            _SkeletonSession(),
            _SkeletonSession()
          ]);
          //return const CircularProgressIndicator();
        } else if (state is HomeLoaded) {
          if (state.listSession.isEmpty) {
            List<Session> list = [
              Session(id: '1', date: DateTime.parse("2000-01-01 00:00:00")),
              const Session(id: '2')
            ];

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10.0),
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  SessionListItem(session: list[index]),
            );
            /*return Text(
              'Aucun rendez-vous planifiés',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left,
            );*/
          } else {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10.0),
              itemCount: state.listSession.length,
              itemBuilder: (context, index) =>
                  SessionListItem(session: state.listSession[index]),
            );
          }
        } else {
          return Text('Something is wrong !');
        }
      },
    );
  }
}

class _SkeletonSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Shimmer(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5.0, color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width * 0.2,
            minWidth: MediaQuery.of(context).size.width * 0.2,
            maxHeight: MediaQuery.of(context).size.width * 0.2,
            maxWidth: MediaQuery.of(context).size.width * 0.2,
          ),
        ),
      ),
    );
  }
}
