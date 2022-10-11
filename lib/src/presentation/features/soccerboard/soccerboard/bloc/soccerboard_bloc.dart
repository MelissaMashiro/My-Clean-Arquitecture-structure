import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'soccerboard_state.dart';
part 'soccerboard_event.dart';
part 'soccerboard_bloc.freezed.dart';

class SoccerboardBloc extends Bloc<SoccerboardEvent, SoccerboardState> {
  SoccerboardBloc() : super(const SoccerboardState.initial()) {
    @override
    Stream<SoccerboardState> mapEventToState(
      SoccerboardEvent event,
    ) async* {
      event.when(
        reload: () async* {
          yield const _LoadInProgress();

          /// do some stuff here
        },
        // reload: (String? nextPageToken) async* {
        //   yield const _Loading();
        //   /// do some stuff here
        // },
      );
    }
  }
}
