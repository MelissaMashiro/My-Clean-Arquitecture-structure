import 'dart:async';
import 'dart:convert';

import 'package:clean_arquitecture_project/src/data/models/client/network_client.dart';
import 'package:clean_arquitecture_project/src/data/models/json/json_config.dart';
import 'package:clean_arquitecture_project/src/data/repositories/soccerboard_repository_impl.dart';
import 'package:clean_arquitecture_project/src/domain/entities/config.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/soccerboard/live_matchs_list_use_case.dart';
import 'package:clean_arquitecture_project/src/presentation/core/app/constants.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/bloc/soccerboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

abstract class Injector {
  Stream<bool> get initializationStream;

  SoccerboardBloc get soccerboardBloc;

  GlobalKey<NavigatorState> get navigatorKey;

  Future<void> initialize();

  void dispose();

  bool isInitialized();
}

class DefaultInjector implements Injector {
  static final Logger _logger = Logger('DefaultInjector');

  final StreamController<bool> _initializationStreamController =
      StreamController<bool>.broadcast();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Config _config;
  late LiveMatchsListUseCase _liveMatchsListUseCase;
  bool _initialized = false;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Stream<bool> get initializationStream =>
      _initializationStreamController.stream;

  @override
  SoccerboardBloc get soccerboardBloc => SoccerboardBloc(
        liveMatchsListUseCase: _liveMatchsListUseCase,
      );

  @override
  void dispose() {
    _logger.finest('Disposing DefaultInjector…');
    _initialized = false;
    _initializationStreamController.add(_initialized);
    _initializationStreamController.close();
  }

  @override
  Future<void> initialize() async {
    if (!isInitialized()) {
      _logger.finest('Loading configuration…');
      final configJson = await rootBundle.loadString(
        Constants.path,
      );

      _config = JsonConfig.fromDynamic(
        json.decode(configJson),
      );

      final networkClient = NetworkClient(apiKey: _config.apiKey);

      _logger.finest('Creating repositories…');

      final soccerboardRepository = SoccerboardRepositoryImpl(
        apikey: _config.apiKey,
        host: _config.host,
        endpoints: _config.endpoints,
        networkClient: networkClient,
      );

      _liveMatchsListUseCase = LiveMatchsListUseCase(
        soccerboardRepository: soccerboardRepository,
      );

      _initialized = true;
      _logger.finest('Initialization completed');
      _initializationStreamController.add(_initialized);
    }
  }

  @override
  bool isInitialized() => _initialized;
}
