class Status {
  final int elapsedTime;
  final String long;
  Status({
    required this.elapsedTime,
    required this.long,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      elapsedTime: json[_AttributeKeys.elapsed],
      long: json[_AttributeKeys.long],
    );
  }

   Map<String, dynamic> toMap() => {
        _AttributeKeys.elapsed: elapsedTime,
        _AttributeKeys.long: long,
    };
}

abstract class _AttributeKeys {
  static const String elapsed = 'elapsed';
  static const String long = 'long';
}
