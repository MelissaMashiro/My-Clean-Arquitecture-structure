class Goal {
 final int away;
  final int home;
  Goal({
    required this.away,
    required this.home,
  });

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
