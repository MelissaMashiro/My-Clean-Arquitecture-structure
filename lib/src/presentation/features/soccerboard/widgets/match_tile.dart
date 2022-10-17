import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({
    Key? key,
    required this.match,
  }) : super(key: key);
  final SoccerMatch match;
  @override
  Widget build(BuildContext context) {
    var homeGoal = match.goal.home;
    var awayGoal = match.goal.away;
    homeGoal ??= 0; //  if (homeGoal == null) homeGoal = 0;
    awayGoal ??= 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              match.home.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.home.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Text(
              "$homeGoal - $awayGoal",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Image.network(
            match.away.logoUrl,
            width: 36.0,
          ),
          Expanded(
            child: Text(
              match.away.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
