import 'package:clean_arquitecture_project/src/data/models/request_models/network_request.dart';

class SoccerboardMatchListRequest extends NetworkRequest {
  SoccerboardMatchListRequest({
    required this.apiKey,
    required this.host,
    required String url,
    required String year,
  }) : super(url: url);

  String host;
  String apiKey;

  @override
  String? get body => null;

  @override
  Map<String, String> get headers => {
        _AttributeKeys.xRapidapiHost: host,
        _AttributeKeys.xRapidapiKey: apiKey,
      };
}

abstract class _AttributeKeys {
  static const String xRapidapiHost = 'x-rapidapi-host';
  static const String xRapidapiKey = 'x-rapidapi-key';
}
