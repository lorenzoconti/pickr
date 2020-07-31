import 'package:pickr/classes/card.dart';

import 'package:flutter/material.dart';

import 'user.dart';

class Player {
  User user;
  List<GameCard> hand = List<GameCard>();
  Player({@required this.user});

  String toString() => user.id + " " + hand.toString();
}
