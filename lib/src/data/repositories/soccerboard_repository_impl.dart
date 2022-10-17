import 'dart:convert';
import 'dart:io';

import 'package:clean_arquitecture_project/src/data/models/client/network_client.dart';
import 'package:clean_arquitecture_project/src/data/models/request_models/soccerboard_match_list_request.dart';
import 'package:clean_arquitecture_project/src/domain/entities/endpoints.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/domain/repositories/soccerboard_repository.dart';

class SoccerboardRepositoryImpl implements SoccerboardRepository {
  SoccerboardRepositoryImpl({
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
  Future<List<SoccerMatch>> getLiveMatched() async {
    final response = await _networkClient.get(
      SoccerboardMatchListRequest(
        apiKey: _apiKey,
        host: _host,
        year: '2020',
        url: _endpoints.matchliveUrl,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception();
    }

    final body = json.decode(
      utf8.decode(response.bodyBytes),
    );
    
    return (body['response'] as List)
        .map((data) => SoccerMatch.fromJson(data))
        .toList();
  }
}
