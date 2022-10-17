import 'package:flutter/material.dart';

class GoalStat extends StatelessWidget {
  const GoalStat({
    Key? key,
    required this.expandedTime,
    required this.homeGoal,
    required this.awayGoal,
  }) : super(key: key);
  final int? expandedTime;
  final int? homeGoal;
  final int? awayGoal;
  @override
  Widget build(BuildContext context) {
    var home = homeGoal;
    var away = awayGoal;
    var elapsed = expandedTime;
    home ??= 0;
    away ??= 0;
    elapsed ??= 0;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$elapsed'",
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "$home - $away",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
