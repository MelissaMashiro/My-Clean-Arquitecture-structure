import 'dart:convert';
import 'dart:io';

import 'package:clean_arquitecture_project/src/data/models/network/network_client.dart';
import 'package:clean_arquitecture_project/src/data/models/request_models/soccerboard_match_list_request.dart';
import 'package:clean_arquitecture_project/src/domain/entities/endpoints.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';

abstract class SoccerboardRemoteDataSource {
  Future<List<SoccerMatch>> getLiveMatched({
    required String year,
  });
}

class SoccerboardRemoteDataSourceImpl implements SoccerboardRemoteDataSource {
  SoccerboardRemoteDataSourceImpl({
    required String apikey,
    required String host,
    required Endpoints endpoints,
    required NetworkClient networkClient,
  })  : _apiKey = apikey,
        _host = host,
        _endpoints = endpoints,
        _networkClient = networkClient;

  final String _apiKey;
  final String _host;
  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<List<SoccerMatch>> getLiveMatched({
    required String year,
  }) async {
    final response = await _networkClient.get(
      SoccerboardMatchListRequest(
        apiKey: _apiKey,
        host: _host,
        year: year,
        url: _endpoints.matchliveUrl,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception(response.body);
    }

    final body = json.decode(
      utf8.decode(response.bodyBytes),
    );

    return (body['response'] as List)
        .map((data) => SoccerMatch.fromJson(data))
        .toList();
  }
}
