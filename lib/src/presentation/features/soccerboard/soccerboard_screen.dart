import 'package:clean_arquitecture_project/src/domain/entities/soccer_match.dart';
import 'package:clean_arquitecture_project/src/presentation/core/core.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/bloc/soccerboard_bloc.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/widgets/goal_stat.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/widgets/match_tile.dart';
import 'package:clean_arquitecture_project/src/presentation/features/soccerboard/widgets/team_stat.dart';
import 'package:clean_arquitecture_project/src/presentation/ui/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SoccerBoardScreen extends StatefulWidget {
  const SoccerBoardScreen({Key? key}) : super(key: key);

  @override
  State<SoccerBoardScreen> createState() => _SoccerBoardScreenState();
}

class _SoccerBoardScreenState extends State<SoccerBoardScreen> {
  late SoccerboardBloc _viewModel;

  @override
  void initState() {
    _viewModel = context.read<Injector>().soccerboardBloc;
    // _viewModel.add(SoccerboardStarted);
    super.initState();
  }

  Widget _buildBody(List<SoccerMatch> allmatches) {
    if (allmatches.isNotEmpty) {
      return Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TeamStat(
                      team: "Local Team",
                      logoUrl: allmatches[0].home.logoUrl,
                      teamName: allmatches[0].home.name,
                    ),
                    GoalStat(
                      expandedTime: allmatches[0].fixture.status.elapsedTime,
                      homeGoal: allmatches[0].goal.home,
                      awayGoal: allmatches[0].goal.away,
                    ),
                    TeamStat(
                      team: "Visitor Team",
                      logoUrl: allmatches[0].away.logoUrl,
                      teamName: allmatches[0].away.name,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4373D9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "MATCHES",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allmatches.length,
                        itemBuilder: (context, index) {
                          return MatchTile(
                            match: allmatches[index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0.0,
        title: const Text(
          "SOCCERBOARD",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => _viewModel
          ..add(
            const SoccerboardEvent.soccerboardStarted(),
          ),
        child: BlocBuilder<SoccerboardBloc, SoccerboardState>(
          builder: (context, state) {
            return state.when(initial: () {
              return const SizedBox();
            }, loading: () {
              return const CircularProgressIndicator();
            }, completed: (matchesList) {
              return _buildBody(matchesList);
            }, error: () {
              return ErrorScreen(
                buttonText: 'Try Again',
                onTap: () => _viewModel.add(
                  const SoccerboardEvent.soccerboardStarted(),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
