import 'package:clean_arquitecture_project/src/domain/entities/fixture.dart';
import 'package:clean_arquitecture_project/src/domain/entities/goal.dart';
import 'package:clean_arquitecture_project/src/domain/entities/team.dart';

class SoccerMatch {
  final Team away;
  final Fixture fixture;
  final Goal goal;
  final Team home;

  SoccerMatch({
    required this.away,
    required this.fixture,
    required this.goal,
    required this.home,
  });

  factory SoccerMatch.fromJson(Map<String, dynamic> json) {
    return SoccerMatch(
      away: Team.fromJson(json[_AttributeKeys.teams][_AttributeKeys.away]),
      fixture: Fixture.fromJson(json[_AttributeKeys.fixture]),
      goal: Goal.fromJson(
        json[_AttributeKeys.goals],
      ),
      home: Team.fromJson(json[_AttributeKeys.teams][_AttributeKeys.home]),
    );
  }
}

abstract class _AttributeKeys {
  static const String away = 'away';
  static const String fixture = 'fixture';
  static const String goals = 'goals';
  static const String home = 'home';
  static const String teams = 'teams';
}
