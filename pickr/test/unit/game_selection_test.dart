import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickr/classes/settings.dart';
import 'package:pickr/enums/games.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/utils/csv_utils.dart';

import 'package:path/path.dart' as Path;
import 'dart:io' show Platform, Directory;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  GameSession game = GameSession();

  var decoder = new FirstOccurrenceSettingsDetector(
      eols: ['\r\n', '\n'], textDelimiters: ['"', "'"]);

  String toAbsPath(path, basedir) {
    Path.Context context;
    if (Platform.isWindows) {
      context = new Path.Context(style: Path.Style.windows);
    } else {
      context = new Path.Context(style: Path.Style.posix);
    }
    basedir ??= Path.dirname(Platform.script.toFilePath());
    path = context.join(basedir, path);
    print(path);
    return context.normalize(path);
  }

  var path = toAbsPath("./test/unit/pickr.csv", Directory.current.path);

  path = path.replaceAll(RegExp(r'\\'), '\\\\');

  print(path);

  //final input = new File('./test/unit/pickr.csv').openRead();
  final input = new File(path).openRead();
  final List<List<dynamic>> fields = await input
      .transform(utf8.decoder)
      .transform(new CsvToListConverter(csvSettingsDetector: decoder))
      .toList();

  // fields.forEach(print);
  /// [valid, validType, validNumPlayers, availableNumPlayers, availableMaxScore, validNumOptions, type, maxScore, numOptions, validMaxScore, numPlayers]
  fields.removeAt(0);

  int i = 0;

  fields.forEach((row) {
    //
    i = i + 1;

    /// Import the parameters from the .csv file exported with CtwEdge
    bool valid = UtilsCSV.booleanCSV(row[0]);
    bool validType = UtilsCSV.booleanCSV(row[1]);
    bool validNumPlayers = UtilsCSV.booleanCSV(row[2]);
    bool availableNumPlayers = UtilsCSV.booleanCSV(row[3]);
    bool availableMaxScore = UtilsCSV.booleanCSV(row[4]);
    bool validNumOptions = UtilsCSV.booleanCSV(row[5]);
    GameType type = UtilsCSV.typeCSV(row[6]);
    List<int> maxScore = UtilsCSV.scoreCSV(row[7]);
    int numOptions = row[8];
    bool validMaxScore = UtilsCSV.booleanCSV(row[9]);
    List<int> numPlayers = UtilsCSV.playersCSV(row[10]);

    //settings.add(Settings());

    /*print(i.toString() +
        " : valid: " +
        valid.toString() +
        " validType: " +
        validType.toString() +
        " validNumPlayers: " +
        validNumPlayers.toString() +
        " validMaxScore: " +
        validMaxScore.toString() +
        " validNumOptions: " +
        validNumOptions.toString() +
        " availableNumPlayers : " +
        availableNumPlayers.toString() +
        " availableMaxScore : " +
        availableMaxScore.toString() +
        " type: " +
        type.toShortString() +
        " numPlayers : " +
        numPlayers.toString() +
        " maxScore: " +
        maxScore.toString() +
        " numOptions: " +
        numOptions.toString());*/

    Settings setting;

    if (valid) {
      //
      setting = Settings(
          available: true,
          availableNumPlayers: availableNumPlayers,
          numPlayers: numPlayers,
          availableScore: availableMaxScore,
          maxScore: maxScore,
          numOptions: numOptions,
          type: type);

      /// Parametrized Test: Valid Parameters, Consistency Check
      test("Test Parametrico $i", () {
        //
        game.setting = setting;
        expect(game.currentSetting != null, true);

        ///Consistency Check
        if (!game.currentSetting.availableNumPlayers)
          game.addOption("numPlayer", game.currentSetting.numPlayers[0]);

        if (!game.currentSetting.availableScore)
          game.addOption("maxScore", game.currentSetting.maxScore[0]);

        game.check();
      });

      //
    } else {
      if (!validType | !validNumOptions | !validMaxScore | !validNumPlayers) {
        /// Parametrized Test : Invalid Parameters.
        ///
        /// If at least one of [type], [numPlayers], [maxScore], [numOptions]
        /// format is wrong, the corresponding UtilsCSV method returns a null
        /// value.
        /// So, the Settings constructor throws an AssertionError.
        test("Test Parametrico $i : Invalid Type", () {
          /// expect Settings constructor throws an AssertionError
          expect(() {
            setting = Settings(
                available: true,
                availableNumPlayers: availableNumPlayers,
                numPlayers: numPlayers,
                availableScore: availableMaxScore,
                maxScore: maxScore,
                numOptions: numOptions,
                type: type);
          }, throwsA(isA<AssertionError>()));
        });
      }
    }
  });
}

//settings.forEach((value) {
//game.setting = value;
//print(value);
//expect(game.currentSettings != null, true);
//});
