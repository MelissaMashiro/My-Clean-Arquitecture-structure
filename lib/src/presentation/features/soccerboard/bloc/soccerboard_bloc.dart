import 'package:bloc/bloc.dart';
import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/domain/usecases/soccerboard/live_matchs_list_use_case.dart';
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
    on<SoccerboardStarted>(_getLiveMatchs);
  }

  SoccerboardState get initialState => const SoccerboardState.initial();

  Future<void> _getLiveMatchs(event, emit) async {
    emit(const SoccerboardState.loading());

    final result = await _liveMatchsListUseCase.call(arguments: {});

    result.fold(
      (error) async {
        emit(const SoccerboardState.error());
      },
      (success) async {
        emit(SoccerboardState.completed(success));
      },
    );
  }
}
