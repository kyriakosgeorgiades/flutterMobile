import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/imageAPI.dart';

import '../apiCalls.dart';

class CurrentGames extends ChangeNotifier {
  int _gameid;
  String _name;
  String _cover;
  int _year;
  List<String> _games;
  Map<String, dynamic> _gamesMap;
  String _singleGame;
  String _fileGame;
  List<String> _pathFiles;

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
  List<String> get getPahts => _pathFiles;
  Map<String, dynamic> get getGamesMap => _gamesMap;

  Future<dynamic> games() async {
    bool flag = false;
    _games = [];
    _pathFiles = [];
    try {
      var response = await CallApi().getData('games');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        flag = true;
        for (var key in body.keys) {
          _games.add(key);
          String path = await ImagesAPI()
              .getPicPath(body[key]['cover'], body[key]['file_name']);
          _pathFiles.add(path);
        }
        print("I AM THE GAMES");

        _gamesMap = body;
        print(_gamesMap);

        notifyListeners();
        return flag;
      }
    } catch (e) {
      print(e);
    }
    return flag;
  }

  Future<dynamic> addgame(Map<String, dynamic> data) async {
    try {
      var response = await CallApi().postDataAuth(data, 'games');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        notifyListeners();
        return 'Game Added';
      } else {
        return 'Game is not added';
      }
    } catch (e) {
      print(e);
    }
  }
}
