import 'package:clean_arquitecture_project/src/core/core.dart';
import 'package:clean_arquitecture_project/src/presentation/ui/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Injector _injector;

  @override
  void initState() {
    super.initState();
    _injector = DefaultInjector();
    _injector.initialize();
  }

  @override
  void dispose() {
    _injector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: _injector.isInitialized(),
      stream: _injector.initializationStream,
      builder: (context, snapshot) {
        Widget result = MaterialApp(
          debugShowCheckedModeBanner: false,
          home: snapshot.data == true ? null : const LoadingScreen(),
          navigatorKey: snapshot.data == true ? _injector.navigatorKey : null,
          onGenerateRoute:
              snapshot.data == true ? AppRouter.generatedRoutes : null,
          title: 'Stripe Customer',
        );

        if (snapshot.data == true) {
          result = MultiProvider(
            providers: [
              Provider<Injector>.value(
                value: _injector,
              ),
            ],
            child: result,
            // child: MultiBlocProvider(
            //   providers:  [
            //     //En caso de querer iniciar el bloc desde aqui
            //     BlocProvider.value(
            //       value: _injector.soccerboardBloc,
            //     ),
            //   ],
            //   child: result,
            // ),
          );
        }

        return result;
      },
    );
  }
}
