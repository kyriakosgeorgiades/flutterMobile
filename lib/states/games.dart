import 'dart:convert';

import 'package:flutter/material.dart';

import '../apiCalls.dart';

class CurrentGames extends ChangeNotifier {
  int _gameid;
  String _name;
  String _cover;
  int _year;
  List<String> _games;
  Map<String, dynamic> _gamesMap;
  String _singleGame;

  void setSingleGame(String name) {
    _singleGame = name;
  }

  void setYear(String year) {}

  String get getSingleGame => _singleGame;
  int get getUid => _gameid;
  String get getName => _name;
  String get getCover => _cover;
  int get getYear => _year;
  List<String> get getGames => _games;
  Map<String, dynamic> get getGamesMap => _gamesMap;

  Future<bool> games() async {
    bool flag = false;
    _games = [];
    try {
      var response = await CallApi().getData('games');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        flag = true;
        for (var key in body.keys) {
          _games.add(key);
        }
        _gamesMap = body;
        notifyListeners();
        return flag;
      }
    } catch (e) {
      print(e);
    }
    return flag;
  }
}
