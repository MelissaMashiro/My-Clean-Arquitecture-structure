class Team {
  final int id;
  final String logoUrl;
  final String name;
  final bool winner;
  Team({
    required this.id,
    required this.logoUrl,
    required this.name,
    required this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json[_AttributeKeys.id],
      logoUrl: json[_AttributeKeys.logo],
      name: json[_AttributeKeys.name],
      winner: json[_AttributeKeys.winner],
    );
  }
}

abstract class _AttributeKeys {
  static const String id = 'id';
  static const String logo = 'logo';
  static const String name = 'name';
  static const String winner = 'winner';
}
