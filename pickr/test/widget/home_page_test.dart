import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pickr/classes/settings.dart';
import 'package:pickr/enums/games.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/pages/home.dart';
import 'package:pickr/providers/game-provider.dart';

class MockGame extends Mock implements GameSessionInterface {}

void main() {
  Widget app(Widget child, GameSessionInterface game) =>
      GameProvider(game: game, child: MaterialApp(home: child));

  testWidgets('Home Page Mock', (WidgetTester tester) async {
    //
    MockGame mockGame = MockGame();

    List<Settings> settings = List<Settings>();
    settings.add(Settings(
        available: true,
        availableNumPlayers: true,
        availableScore: true,
        maxScore: [5, 10],
        numOptions: 2,
        numPlayers: [2, 4],
        type: GameType.BRISCOLA));

    when(mockGame.settings).thenReturn(settings);

    HomePage page = HomePage();

    await tester.pumpWidget(app(page, mockGame));

    expect(find.text("BRISCOLA"), findsOneWidget);

    await tester.tap(find.byKey(Key("BRISCOLA"))).then((value) async {
      when(mockGame.currentSetting).thenReturn(settings.first);
      await tester.pump();
    });

    expect(find.text("Impostazioni di gioco"), findsOneWidget);
    expect(find.byKey(Key("numPlayers4")), findsOneWidget);
    await tester.tap(find.byKey(Key("numPlayers4")));

    expect(find.byKey(Key("maxScore5")), findsOneWidget);
    await tester.tap(find.byKey(Key("maxScore5")));

    expect(find.byKey(Key("create_lobby")), findsOneWidget);
  });
}
