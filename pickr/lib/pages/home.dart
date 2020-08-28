import 'package:flutter/material.dart';
import 'package:pickr/enums/games.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/providers/game-provider.dart';
import 'package:pickr/widgets/settings_row.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  /// [_selected] is true if the user has already selected a game type,
  /// otherwise false.
  bool _selected = false;

  Widget unavailable = Container(
      child:
          Text("Attualmente non disponibile", style: TextStyle(fontSize: 18)));

  /*
   * build
   *    _buildBody
   *      _title
   *      _gameSection
   *      _settingsSection
   *      
   * 
   */

  @override
  Widget build(BuildContext context) {
    //
    final GameSessionInterface game = GameProvider.of(context).game;

    return Scaffold(
        appBar: AppBar(title: Text("Pickr")), body: _buildBody(game));
  }

  /// Builds the body of the page.
  Widget _buildBody(GameSessionInterface game) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Seleziona una modalità di gioco",
                style: TextStyle(fontSize: 18)),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildOptions(game)),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: _selected
                ? game.currentSetting != null
                    ? _settingsSection(game)
                    : unavailable
                : Container(),
          )
        ],
      ),
    );
  }

  List<Widget> _buildOptions(GameSessionInterface game) {
    //
    List<Widget> options = List<Widget>();
    game.settings.forEach((setting) {
      options.add(RaisedButton(
          key: Key(setting.type.toShortString()),
          onPressed: () => _onButtonPressed(setting.type, game),
          child: Text(setting.type.toShortString())));
    });
    return options;
  }

  /// When the user selects a game type, updates the [_type] and
  /// [_selectedSetting] in order to show the correct settings section below.
  void _onButtonPressed(GameType type, GameSessionInterface game) {
    setState(() {
      game.setSetting(type);
      _selected = true;
    });
  }

  /// Builds the settings section.
  Widget _settingsSection(GameSessionInterface game) {
    List<Widget> _settingWidgets = List<Widget>();

    /// Adds the section title
    _settingWidgets.add(Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text("Impostazioni di gioco", style: TextStyle(fontSize: 18))));

    /// Adds the Number of Players option if it is available.
    if (game.currentSetting.availableNumPlayers) {
      _settingWidgets.add(SettingsRow(
        title: "numPlayers",
        options: game.currentSetting.numPlayers,
        callback: game.addOption,
      ));
    }

    /// Adds the Max Score option if it is available
    if (game.currentSetting.availableScore) {
      _settingWidgets.add(SettingsRow(
        title: "maxScore",
        options: game.currentSetting.maxScore,
        callback: game.addOption,
      ));

      /// Adds the button to create the game lobby if the user chose one value for
      /// every available option.
      _settingWidgets.add(GestureDetector(
        onTap: () {
          game.createLobby().then(
              (value) => Navigator.pushReplacementNamed(context, '/lobby'));
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(top: 40),
            child: Center(
                child: Text("Crea una partita",
                    key: Key("create_lobby"),
                    style: TextStyle(fontSize: 18, color: Colors.white)))),
      ));
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: game.currentSetting.available
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _settingWidgets)
            : unavailable);
  }
}
