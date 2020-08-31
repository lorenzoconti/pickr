import 'package:pickr/enums/games.dart';

class UtilsCSV {
  //
  /// Returns the game type corresponding to the string.
  static GameType typeCSV(String type) {
    switch (type) {
      case 'Briscola':
        return GameType.BRISCOLA;
        break;
      case 'Chiamata':
        return GameType.BRISCOLA_CHIAMATA;
        break;
      case 'Domino':
        return GameType.DOMINO;
        break;
      case 'Marianna':
        return GameType.MARIANNA;
        break;
      default:
        return null;
    }
  }

  /// Returns the boolean value corresponding to the string.
  static bool booleanCSV(String boolean) {
    switch (boolean) {
      case 'true':
        return true;
        break;
      case 'false':
        return false;
        break;
      default:
        return true;
    }
  }

  /// Returns the integer corresponding to the string.
  static int numberCSV(String num) {
    return int.tryParse(num);
  }

  /// Returns the list of scores corresponding to the string.
  static List<int> scoreCSV(String score) {
    switch (score) {
      case 'Standard':
        return [5, 10, 20];
        break;
      case 'None':
        return [0];
        break;
      default:
        return null;
    }
  }

  /// Returns the list of number of players corresponding to the string.
  static List<int> playersCSV(String players) {
    switch (players) {
      case 'Couple':
        return [2, 4];
        break;
      case 'Five':
        return [5];
        break;
      case 'None':
        return [0];
        break;
      default:
        return null;
    }
  }
}
