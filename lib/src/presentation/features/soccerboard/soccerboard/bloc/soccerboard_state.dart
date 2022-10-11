part of 'soccerboard_bloc.dart';

@freezed
class SoccerboardState with _$SoccerboardState {
  const factory SoccerboardState.initial() = _Initial;
  const factory SoccerboardState.loadInProgress() = _LoadInProgress;
}