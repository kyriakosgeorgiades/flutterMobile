import 'dart:convert';

import 'package:flutter/material.dart';

import '../apiCalls.dart';

class CurrentSingle extends ChangeNotifier {
  Map<String, dynamic> _singleInfo;
  Map<String, dynamic> _reviewsMap;
  List<String> _idReviews;

  List<String> get getReviewsIDs => _idReviews;
  Map<String, dynamic> get getReviewsMap => _reviewsMap;

  //String get getSingleGame => _singleGame;

  Future<Map<String, dynamic>> singleGame(String name) async {
    _singleInfo = {};
    try {
      String endpoint = 'games/' + name;
      var response = await CallApi().getData(endpoint);
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        body.forEach((key, value) => _singleInfo.addAll({key: value}));
      }
      print("IN BODY TESTING");
      print(body);
      notifyListeners();
      return _singleInfo;
    } catch (e) {
      print(e);
    }
    return _singleInfo;
  }

  Future<bool> reviewsGame(String name) async {
    bool check = false;
    _idReviews = [];
    try {
      String endpoint = 'games/' + name + '/reviews';
      var response = await CallApi().getData(endpoint);
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("BODY OF REVIEWS");
        print(body);
        for (var key in body.keys) {
          print("KEY: ${key}");
          _idReviews.add(key);
        }
        _reviewsMap = body;
        print("I AM THE REVIEWS MAP");
        print(_reviewsMap);
        notifyListeners();
        check = true;
        return check;
      }
    } catch (e) {
      print(e);
    }
    return check;
  }
}
