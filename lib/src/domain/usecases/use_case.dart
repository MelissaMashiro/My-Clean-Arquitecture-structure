
import 'package:clean_arquitecture_project/src/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Success> {
  Future<Either<Failure, Success>> call({
    required Map<String, dynamic> arguments,
  });
}
