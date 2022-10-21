import 'package:clean_arquitecture_project/src/domain/entities/endpoints.dart';

class Config {
  Config({
    required this.apiKey,
    required this.databaseFileName,
    required this.endpoints,
    required this.host,
  });

  final String apiKey;
  final String databaseFileName;
  final Endpoints endpoints;
  final String host;
}
