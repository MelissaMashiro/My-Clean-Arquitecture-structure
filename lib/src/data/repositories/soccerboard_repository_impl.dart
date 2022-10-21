import 'package:clean_arquitecture_project/src/data/datasources/local/soccerboard_local_data_source.dart';
import 'package:clean_arquitecture_project/src/data/datasources/remote/soccerboard_remote_data_source.dart';
import 'package:clean_arquitecture_project/src/data/models/network/network_info.dart';
import 'package:clean_arquitecture_project/src/domain/entities/cache_exception.dart';
import 'package:clean_arquitecture_project/src/domain/entities/failure.dart';
import 'package:clean_arquitecture_project/src/domain/entities/server_exception.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/domain/repositories/soccerboard_repository.dart';
import 'package:dartz/dartz.dart';

class SoccerboardRepositoryImpl implements SoccerboardRepository {
  final NetworkInfo _networkInfo;
  final SoccerboardLocalDataSource _soccerboardLocalDataSource;
  final SoccerboardRemoteDataSource _soccerboardRemoteDataSource;

  SoccerboardRepositoryImpl({
    required soccerboardRemoteDataSource,
    required soccerboardLocalDataSource,
    required networkInfo,
  })  : _networkInfo = networkInfo,
        _soccerboardLocalDataSource = soccerboardLocalDataSource,
        _soccerboardRemoteDataSource = soccerboardRemoteDataSource;
  @override
  Future<Either<Failure, List<SoccerMatch>>> getLiveMatched({
    required String year,
  }) async {
    if (await _networkInfo.isConnected) {
      print('--->SI HAY CONECCION');
      try {
        final remoteSoccerboardList =
            await _soccerboardRemoteDataSource.getLiveMatched(year: year);
        print('--->GUARDANDO EN STORAGE');

        remoteSoccerboardList.forEach((soccerMatch) async {
          await _soccerboardLocalDataSource.store(soccerMatch);
        });

        return Right(remoteSoccerboardList);
      } on ServerException catch (se) {
        return Left(Failure(
          code: se.code,
          message: se.message,
        ));
      } on Exception catch (_) {
        return Left(
          Failure(message: 'Unknown Error'),
        );
      }
    } else {
      print('--->NO HAY CONECCION');

      try {
        final localSoccerboardList =
            await _soccerboardLocalDataSource.getSavedSoccerMatchs();
        print('--->LISTA SACADA DE STORAGE');

        return Right(localSoccerboardList);
      } on CacheException {
        print('--->ERROR SACANDO LISTA DEL STORAGE');

        return Left(
          Failure(message: 'Error trayendo la Informacion del cache '),
        );
      } on Exception catch (_) {
        return Left(
          Failure(message: 'Unknown Error'),
        );
      }
    }
  }
}
