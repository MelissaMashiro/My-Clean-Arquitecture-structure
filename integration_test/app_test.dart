import 'package:clean_arquitecture_project/src/core/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  Future<void> addDelay(int ms) async {
    await Future<void>.delayed(Duration(milliseconds: ms));
  }

  group('end-to-end test', () {
    // ignore: unused_local_variable
    final timeBasedEmail = '${DateTime.now().microsecondsSinceEpoch}@test.com';

    testWidgets('Authentication Testing', (WidgetTester tester) async {
      Logger.root.level = Level.ALL;
      Logger.root.onRecord.listen((record) {
        debugPrint('${record.level.name}: ${record.time}: ${record.message}');
      });

      tester.printToConsole('Starting authentication');

      await tester.pumpWidget(const App());

      await tester.pumpAndSettle();

      //await tester.tap(find.byType(AbastibleTextFormField));
//1
      tester.printToConsole('SignUp screen opens');
//2

      await addDelay(24000);
      await tester.pumpAndSettle();
      expect(find.text('SOCCERBOARD'), findsOneWidget);
    });

    //TODO: add test 2 here
  });
}
