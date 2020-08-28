import 'package:pickr/classes/settings.dart';
import 'package:pickr/enums/games.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickr/utils/csv_utils.dart';

abstract class GameSessionInterface {
  //
  Settings get currentSetting;
  List<Settings> get settings;
  String get lobby;

  set setSettings(List<Settings> list);

  void setSetting(GameType type);
  int addOption(String title, Object value);
  Future<bool> createLobby();

  Future<List<Settings>> getSettings();

  Future<void> fetch();

  bool check();
}

class GameSession implements GameSessionInterface {
  //
  final db = Firestore.instance;

  /// Contains the game type that the user chose.
  GameType _type;

  ///
  String _lobby;

  String get lobby => _lobby;

  /// (Key,Value) map that contains the settings options the user selected
  Map<String, Object> _gameSettings = Map<String, Object>();

  /// List of the settings, one setting for every game type.
  List<Settings> _settings = List<Settings>();

  List<Settings> get settings => _settings;

  /// Selected setting based on [_type]
  Settings _selectedSetting;

  Settings get currentSetting => _selectedSetting;

  set setting(Settings setting) => _selectedSetting = setting;

  set setSettings(List<Settings> list) => _settings = list;

  /// Sets the current settings options based on the game type the user selected.
  void setSetting(GameType type) {
    //
    _type = type;
    _gameSettings.clear();
    _selectedSetting = _settings.firstWhere((element) => element.type == type,
        orElse: () => null);
  }

  /// Inserts a (Key = title, Value = value) entry in the [_gameSettings] map.
  ///
  /// If a previous value of the same setting is contained, it replaces
  /// it with the new one.
  int addOption(String title, Object value) {
    //
    if (_gameSettings.containsKey(title)) _gameSettings.remove(title);

    _gameSettings.putIfAbsent(title, () => value);
    print(_gameSettings);

    return _gameSettings.length;
  }

  bool check() {
    print(_type);
    print(_gameSettings);

    if (_type == GameType.BRISCOLA_CHIAMATA && _gameSettings["numPlayers"] != 5)
      return false;
    if (_type == GameType.BRISCOLA &&
        (_gameSettings["numPlayers"] != 2 && _gameSettings["numPlayers"] != 4))
      return false;
    return true;
  }

  /// Checks that the user selected at least one option
  /// of each selectable setting.
  bool everythingChecked() {
    return _gameSettings.length == selectableOptions();
  }

  /// Starts the game lobby
  void start() {
    print("Game Started with the following options:");
    print(_gameSettings);
  }

  /// Returns the number of selectable options based on
  /// availableNumPlayers and availableScore
  int selectableOptions() {
    return (_selectedSetting.availableNumPlayers ? 1 : 0) +
        (_selectedSetting.availableScore ? 1 : 0);
  }

  Future<List<Settings>> getSettings() async {
    List<Settings> _fetched = List<Settings>();

    await db.collection("settings").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        if (result.data["available"] == "true") {
          _fetched.add(Settings(
              available: UtilsCSV.booleanCSV(result.data["available"]),
              availableNumPlayers:
                  UtilsCSV.booleanCSV(result.data["availableNumPlayers"]),
              availableScore:
                  UtilsCSV.booleanCSV(result.data["availableScore"]),
              maxScore: UtilsCSV.scoreCSV(result.data["maxScore"]),
              numOptions: UtilsCSV.numberCSV(result.data["numOptions"]),
              numPlayers: UtilsCSV.playersCSV(result.data["numPlayers"]),
              type: UtilsCSV.typeCSV(result.data["type"])));
        } else {
          _settings.add(Settings(
              available: false,
              availableNumPlayers: false,
              availableScore: false,
              maxScore: [0],
              numOptions: 0,
              numPlayers: [0],
              type: UtilsCSV.typeCSV(result.data["type"])));
        }
      });
    });
    _fetched.forEach((element) {
      print(element);
    });
    return _fetched;
  }

  Future<bool> createLobby() async {
    //
    try {
      DocumentReference ref = await db.collection("games").add({
        'type': _type.toShortString(),
        'maxScore': _gameSettings["maxScore"].toString(),
        'numPlayers': _gameSettings["numPlayers"].toString(),
      });

      _lobby = ref.documentID;

      print(_lobby);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> fetch() async {
    List<Settings> _fetched = await this.getSettings();
    _settings = _fetched;
    return;
  }
}
