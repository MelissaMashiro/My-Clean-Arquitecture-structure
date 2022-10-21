import 'package:clean_arquitecture_project/src/domain/entities/failure.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:dartz/dartz.dart';

abstract class SoccerboardRepository {
  Future<Either<Failure, List<SoccerMatch>>> getLiveMatched({
    required String year,
  });
}
