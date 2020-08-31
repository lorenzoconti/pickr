import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pickr/classes/settings.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/utils/csv_utils.dart';

// ignore: library_prefixes
import 'package:path/path.dart' as Path;
import 'dart:io' show Platform, Directory;

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  var game = GameSession();

  var decoder = FirstOccurrenceSettingsDetector(
      eols: ['\r\n', '\n'], textDelimiters: ['"', "'"]);

  /// Finds the absolute path of the current folder.
  String toAbsPath(path, basedir) {
    Path.Context context;
    if (Platform.isWindows) {
      context = Path.Context(style: Path.Style.windows);
    } else {
      context = Path.Context(style: Path.Style.posix);
    }
    basedir ??= Path.dirname(Platform.script.toFilePath());
    path = context.join(basedir, path);
    return context.normalize(path);
  }

  //var path = toAbsPath("./test/unit/pickr.csv", Directory.current.path);
  var path = toAbsPath('./unit/pickr.csv', Directory.current.path);

  path = path.replaceAll(RegExp(r'\\'), '\\\\');

  final input = File(path).openRead();
  final fields = await input
      .transform(utf8.decoder)
      .transform(CsvToListConverter(csvSettingsDetector: decoder))
      .toList();

  /// List of the parameters:
  ///
  /// [ valid, validType, validNumPlayers, availableNumPlayers,
  ///   availableMaxScore, validNumOptions, type, maxScore, numOptions,
  ///   validMaxScore, numPlayers ]
  fields.removeAt(0);

  var i = 0;

  fields.forEach((row) {
    //
    i = i + 1;

    /// Import the parameters from the .csv file exported with CtwEdge
    var valid = UtilsCSV.booleanCSV(row[0]);
    var validType = UtilsCSV.booleanCSV(row[1]);
    var validNumPlayers = UtilsCSV.booleanCSV(row[2]);
    var availableNumPlayers = UtilsCSV.booleanCSV(row[3]);
    var availableMaxScore = UtilsCSV.booleanCSV(row[4]);
    var validNumOptions = UtilsCSV.booleanCSV(row[5]);
    var type = UtilsCSV.typeCSV(row[6]);
    var maxScore = UtilsCSV.scoreCSV(row[7]);
    int numOptions = row[8];
    var validMaxScore = UtilsCSV.booleanCSV(row[9]);
    var numPlayers = UtilsCSV.playersCSV(row[10]);

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
      test('Test Parametrico $i', () {
        //
        game.setting = setting;
        expect(game.currentSetting != null, true);

        ///Consistency Check
        if (!game.currentSetting.availableNumPlayers) {
          game.addOption('numPlayer', game.currentSetting.numPlayers[0]);
        }

        if (!game.currentSetting.availableScore) {
          game.addOption('maxScore', game.currentSetting.maxScore[0]);
        }

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
        test('Test Parametrico $i : Invalid Type', () {
          /// Expects Settings constructor throws an AssertionError
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
