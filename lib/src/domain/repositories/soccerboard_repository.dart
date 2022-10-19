import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';

abstract class SoccerboardRepository {
  Future<List<SoccerMatch>> getLiveMatched({
    required String year,
  });
}
