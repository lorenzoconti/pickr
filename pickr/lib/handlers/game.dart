import 'package:pickr/classes/settings.dart';
import 'package:pickr/enums/games.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameSessionInterface {}

class GameSession implements GameSessionInterface {
  //
  final db = Firestore.instance;

  /// Contains the game type that the user chose.
  GameType _type;

  ///
  String lobby;

  /// (Key,Value) map that contains the settings options the user selected
  Map<String, Object> _gameSettings = Map<String, Object>();

  /// List of the settings, one setting for every game type.
  List<Settings> _settings = List<Settings>();

  /// Selected setting based on [_type]
  Settings _selectedSetting;

  Settings get currentSetting => _selectedSetting;

  set setting(Settings setting) => _selectedSetting = setting;

  /// Sets the current settings options based on the game type the user selected.
  void setSetting(GameType type) {
    //
    _type = type;
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

  Future<void> createLobby() async {
    //

    DocumentReference ref = await db.collection("games").add({
      'type': _type.toShortString(),
      'maxScore': _gameSettings["maxScore"].toString(),
      'numPlayers': _gameSettings["numPlayers"].toString(),
    });

    lobby = ref.documentID;

    print(lobby);
  }

  void mockSettings() {
    _settings.add(Settings(
        available: true,
        availableNumPlayers: true,
        availableScore: true,
        numOptions: 2,
        numPlayers: [2, 4],
        maxScore: [5, 10, 20],
        type: GameType.BRISCOLA));
    //
    _settings.add(Settings(
        available: true,
        availableNumPlayers: false,
        availableScore: true,
        numOptions: 1,
        numPlayers: [5],
        maxScore: [5, 10, 20],
        type: GameType.BRISCOLA_CHIAMATA));
  }
}
