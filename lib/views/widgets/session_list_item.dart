import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:flutter/material.dart';

class SessionListItem extends StatelessWidget {
  final Session session;

  const SessionListItem({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(session.dayString),
          Text(session.numDay.toString()),
          Text(session.monthString),
        ],
      ),
    );
  }
}
