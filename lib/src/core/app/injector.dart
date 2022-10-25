import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:clean_arquitecture_project/src/core/core.dart';
import 'package:clean_arquitecture_project/src/data/datasources/local/soccerboard_local_data_source.dart';
import 'package:clean_arquitecture_project/src/data/models/network/network_client.dart';
import 'package:clean_arquitecture_project/src/data/models/json/json_config.dart';
import 'package:clean_arquitecture_project/src/data/datasources/remote/soccerboard_remote_data_source.dart';
import 'package:clean_arquitecture_project/src/data/models/network/network_info.dart';
import 'package:clean_arquitecture_project/src/data/repositories/soccerboard_repository_impl.dart';
import 'package:clean_arquitecture_project/src/domain/entities/config.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/soccerboard/live_matchs_list_use_case.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/bloc/soccerboard_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  late Database _database;
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

      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _config.databaseFileName);
      _database = await databaseFactoryIo.openDatabase(dbPath);

      final networkClient = NetworkClient(apiKey: _config.apiKey);
      final networkInfo = NetworkInfoImpl(Connectivity());

      _logger.finest('Creating repositories…');

      final soccerboardRemoteDataSource = SoccerboardRemoteDataSourceImpl(
        apikey: _config.apiKey,
        host: _config.host,
        endpoints: _config.endpoints,
        networkClient: networkClient,
      );

      final soccerboardLocalDataSource =
          SoccerboardLocalDataSourceImpl(database: _database);

      final soccerboardRepository = SoccerboardRepositoryImpl(
        networkInfo: networkInfo,
        soccerboardLocalDataSource: soccerboardLocalDataSource,
        soccerboardRemoteDataSource: soccerboardRemoteDataSource,
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
