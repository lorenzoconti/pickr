import 'package:pickr/enums/games.dart';

class UtilsCSV {
  //
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

  static bool booleanCSV(String boolean) {
    switch (boolean) {
      case 'true':
        return true;
        break;
      case 'false':
        return false;
        break;
      default:
        print(boolean);
        return true;
    }
  }

  //
  static int numberCSV(String num) {
    return int.tryParse(num);
  }

  //
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
