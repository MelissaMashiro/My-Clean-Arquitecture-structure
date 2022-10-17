import 'package:clean_arquitecture_project/src/data/models/json/json_endpoint.dart';
import 'package:clean_arquitecture_project/src/domain/entities/config.dart';

class JsonConfig extends Config {
  JsonConfig({
    required super.apiKey,
    required super.endpoints,
    required super.host,
  });

  factory JsonConfig.fromDynamic(dynamic map) => JsonConfig(
        apiKey: map[_AttributesKeys.apiKey],
        endpoints: JsonEndpoints.fromDynamic(map[_AttributesKeys.endpoints]),
        host: map[_AttributesKeys.host],
      );
}

abstract class _AttributesKeys {
  static const apiKey = 'apiKey';
  static const endpoints = 'endpoints';
  static const host = 'host';
}
