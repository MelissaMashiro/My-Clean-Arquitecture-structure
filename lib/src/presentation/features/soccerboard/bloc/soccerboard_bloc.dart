import 'package:clean_arquitecture_project/src/domain/usecases/soccerboard/live_matchs_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'soccerboard_state.dart';
part 'soccerboard_event.dart';
part 'soccerboard_bloc.freezed.dart';

class SoccerboardBloc extends Bloc<SoccerboardEvent, SoccerboardState> {
  final LiveMatchsListUseCase _liveMatchsListUseCase;

  SoccerboardBloc({
    required LiveMatchsListUseCase liveMatchsListUseCase,
  })  : _liveMatchsListUseCase = liveMatchsListUseCase,
        super(const SoccerboardState.initial()) {
    @override
    Stream<SoccerboardState> mapEventToState(
      SoccerboardEvent event,
    ) async* {
      event.when(
        soccerboardStarted: () => _getLiveMatchs(),
        // reload: (String? nextPageToken) async* {
        //   yield const _Loading();
        //   /// do some stuff here
        // },
      );
    }
  }

  Stream<SoccerboardState> _getLiveMatchs() async* {
    print('ENTRE A METODO BLOC--->');
    yield const _Loading();
    print('CARGANDO--->');
    final result = await _liveMatchsListUseCase.call(arguments: {});

    result.fold(
      (error) async* {
        yield const _Error();
      },
      (success) async* {
        yield const _Completed();
      },
    );
  }
}
