import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/pages/home.dart';
import 'package:pickr/providers/game-provider.dart';

class MockGame extends Mock implements GameSessionInterface {}

void main() {
  Widget app(Widget child, GameSessionInterface game) =>
      GameProvider(game: game, child: MaterialApp(home: child));
  testWidgets('Valid Email and Password: Sign in', (WidgetTester tester) async {
    HomePage page = HomePage();

    MockGame mockGame = MockGame();

    await tester.pumpWidget(app(page, mockGame));
  });
}
