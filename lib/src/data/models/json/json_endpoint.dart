
import 'package:clean_arquitecture_project/src/domain/entities/endpoints.dart';

class JsonEndpoints extends Endpoints {
  JsonEndpoints({
    required super.matchliveUrl,
  });

  factory JsonEndpoints.fromDynamic(dynamic map) => JsonEndpoints(
        matchliveUrl: map[_AttributesKeys.matchliveUrl],
       );
}

abstract class _AttributesKeys {
  static const matchliveUrl = 'matchliveUrl';
}
