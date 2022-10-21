import 'package:clean_arquitecture_project/src/domain/entities/status.dart';

class Fixture {
  final String date;
  final int id;
  final Status status;

  Fixture({
    required this.date,
    required this.id,
    required this.status,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      date: json[_AttributeKeys.date],
      id: json[_AttributeKeys.id],
      status: Status.fromJson(
        json[_AttributeKeys.status],
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        _AttributeKeys.date: date,
        _AttributeKeys.id: id,
        _AttributeKeys.status: status,
      };
}

abstract class _AttributeKeys {
  static const String date = 'date';
  static const String id = 'id';
  static const String status = 'status';
}
