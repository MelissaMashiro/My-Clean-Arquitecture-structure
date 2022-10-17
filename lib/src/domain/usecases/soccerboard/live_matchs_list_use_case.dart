import 'package:clean_arquitecture_project/src/domain/entities/failure.dart';
import 'package:clean_arquitecture_project/src/domain/entities/server_exception.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/domain/repositories/soccerboard_repository.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class LiveMatchsListUseCase extends UseCase<List<SoccerMatch>> {
  LiveMatchsListUseCase({
    required SoccerboardRepository soccerboardRepository,
  }) : _soccerboardRepository = soccerboardRepository;

  final SoccerboardRepository _soccerboardRepository;

  @override
  Future<Either<Failure, List<SoccerMatch>>> call(
      {required Map<String, dynamic> arguments}) async {
    try {
      final result = await _soccerboardRepository.getLiveMatched();

      return Right(result);
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
  }
}
