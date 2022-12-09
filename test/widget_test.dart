import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/domain/repositories/soccerboard_repository.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/soccerboard/live_matchs_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements SoccerboardRepository {}

void main() {
  late LiveMatchsListUseCase liveMatchsListUseCase;

  late MockPostRepository repository;

  setUp(() {
    repository = MockPostRepository();

    liveMatchsListUseCase =
        LiveMatchsListUseCase(soccerboardRepository: repository);
  });

  //CREANDO EL MOCK DE LA RESPUESTA:

  final soccerMatchsFromService = <SoccerMatch>[
    // SoccerMatch(title: 'Test 1', content: 'Test 1 content'),
  ];

  test('Should get all live matches from server', () async {
    //MOCKEANDO LA RESPUESTA: Se debe hacer directamente al metodo del repo q se usará, no al usecase
    when(
      () => repository.getLiveMatched(
        year: '2021',
      ),
    ).thenAnswer(
      (_) async => Right(soccerMatchsFromService),
    );

//implementando endpoint
    final result = await liveMatchsListUseCase(arguments: {
      'year': '2021',
    });

//verificando que hayamos tenido una respuesta exitosa con el endpoint
    expect(
      result,
      Right(soccerMatchsFromService),
    );

//Verify that a method on a mock object was called with the given arguments.

    verify(
      () => repository.getLiveMatched(year: '2021'),
    );

    verifyNoMoreInteractions(repository);
  });
}
