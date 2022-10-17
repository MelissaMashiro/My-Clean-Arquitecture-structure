part of 'soccerboard_bloc.dart';

@freezed
class SoccerboardState with _$SoccerboardState {
  const factory SoccerboardState.completed() = _Completed;
  const factory SoccerboardState.error() = _Error;
  const factory SoccerboardState.initial() = _Initial;
  const factory SoccerboardState.loading() = _Loading;
}
