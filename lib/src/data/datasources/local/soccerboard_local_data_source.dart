import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:sembast/sembast.dart';

abstract class SoccerboardLocalDataSource {
  Future<List<SoccerMatch>> getSavedSoccerMatchs();

  Future<void> store(SoccerMatch soccerMatch);

  Future<void> update(SoccerMatch soccerMatch);
}

class SoccerboardLocalDataSourceImpl implements SoccerboardLocalDataSource {
  SoccerboardLocalDataSourceImpl({
    required Database database,
  }) : _database = database;

  final Database _database;
  final _soccerMatchStore = stringMapStoreFactory.store(
    SoccerMatch.storeName,
  );

  @override
  Future<List<SoccerMatch>> getSavedSoccerMatchs() async {
    final snapshot = await _soccerMatchStore.find(
      _database,
      finder: null,
    );

    return SoccerMatch.fromDynamicList(snapshot);
  }

  @override
  Future<void> store(SoccerMatch soccerMatch) async {
    await _database.transaction(
      (txn) async => await _soccerMatchStore.add(
        txn,
        soccerMatch.toMap(),
      ),
    );
  }

  @override
  Future<void> update(SoccerMatch soccerMatch) async {
    await _database.transaction(
      (transaction) async {
        await _soccerMatchStore.update(
          transaction,
          soccerMatch.toMap(),
          finder: Finder(
            filter: Filter.equals(
              'id',
              soccerMatch.fixture.id,
            ),
          ),
        );
      },
    );
  }
}
