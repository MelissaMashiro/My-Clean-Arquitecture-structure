import 'package:clean_arquitecture_project/src/domain/entities/fixture.dart';
import 'package:clean_arquitecture_project/src/domain/entities/goal.dart';
import 'package:clean_arquitecture_project/src/domain/entities/team.dart';

class SoccerMatch {
  SoccerMatch({
    required this.away,
    required this.fixture,
    required this.goal,
    required this.home,
  });

  static const storeName = 'soccerMatch';

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

  factory SoccerMatch.fromSavedJson(Map<String, dynamic> json) {
    return SoccerMatch(
      away: Team.fromJson(json[_AttributeKeys.away]),
      fixture: Fixture.fromJson(json[_AttributeKeys.fixture]),
      goal: Goal.fromJson(
        json[_AttributeKeys.goals],
      ),
      home: Team.fromJson(json[_AttributeKeys.home]),
    );
  }

  final Team away;
  final Fixture fixture;
  final Goal goal;
  final Team home;

  static List<SoccerMatch> fromDynamicList(dynamic list) {
    var result = <SoccerMatch>[];

    if (list != null) {
      result = [];
      for (dynamic map in list) {
        result.add(
          SoccerMatch.fromJson(map.value),
        );
      }
    }

    return result;
  }

   static List<SoccerMatch> fromSavedDynamicList(dynamic list) {
    var result = <SoccerMatch>[];

    if (list != null) {
      result = [];
      for (dynamic map in list) {
        result.add(
          SoccerMatch.fromSavedJson(map.value),
        );
      }
    }

    return result;
  }

  Map<String, dynamic> toMap() => {
        _AttributeKeys.away: away.toMap(),
        _AttributeKeys.fixture: fixture.toMap(),
        _AttributeKeys.goals: goal.toMap(),
        _AttributeKeys.home: home.toMap(),
      };
}

abstract class _AttributeKeys {
  static const String away = 'away';
  static const String fixture = 'fixture';
  static const String goals = 'goals';
  static const String home = 'home';
  static const String teams = 'teams';
}
