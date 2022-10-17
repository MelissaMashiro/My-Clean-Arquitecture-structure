class Goal {
  Goal({
    required this.away,
    required this.home,
  });

  final int? away;
  final int? home;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      away: json[_AttributeKeys.away],
      home: json[_AttributeKeys.home],
    );
  }
}

abstract class _AttributeKeys {
  static const String away = 'away';
  static const String home = 'home';
}
