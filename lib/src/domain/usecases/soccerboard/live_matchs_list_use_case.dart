import 'package:clean_arquitecture_project/src/domain/entities/failure.dart';
import 'package:clean_arquitecture_project/src/domain/entities/server_exception.dart';
import 'package:clean_arquitecture_project/src/domain/repositories/soccerboard_repository.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/use_case.dart';
import 'package:dartz/dartz.dart';

class LiveMatchsListUseCase extends UseCase<bool> {
  LiveMatchsListUseCase({
    required SoccerboardRepository soccerboardRepository,
  }) : _soccerboardRepository = soccerboardRepository;

  final SoccerboardRepository _soccerboardRepository;

  @override
  Future<Either<Failure, bool>> call(
      {required Map<String, dynamic> arguments}) async {
    try {
      await _soccerboardRepository.getLiveMatched(
      );

      return const Right(true);
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