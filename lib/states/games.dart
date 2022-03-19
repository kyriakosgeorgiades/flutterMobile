import 'dart:convert';
import 'dart:typed_data';

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
  String _fileGame;
  List<Uint8List> _bytesFiles;

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
  List<Uint8List> get getBytes => _bytesFiles;
  Map<String, dynamic> get getGamesMap => _gamesMap;

  Future<dynamic> games() async {
    bool flag = false;
    _games = [];
    _bytesFiles = [];
    try {
      var response = await CallApi().getData('games');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        flag = true;
        for (var key in body.keys) {
          _games.add(key);
          final Uint8List bytesFile = base64Decode(body[key]['cover']);
          _bytesFiles.add(bytesFile);
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

  Future<bool> addgame(Map<String, dynamic> data) async {
    bool flag = false;
    try {
      var response = await CallApi().postDataAuth(data, 'games');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        flag = true;
        notifyListeners();
        return flag;
      } else {
        return flag;
      }
    } catch (e) {
      print(e);
    }
  }
}
