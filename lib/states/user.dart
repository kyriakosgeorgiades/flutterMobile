import 'dart:convert';

import 'package:flutter/material.dart';

import '../apiCalls.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CurrentUser extends ChangeNotifier {
  int _uid;
  String _username;
  String _token;
  static final _storage = new FlutterSecureStorage();

  int get getUid => _uid;

  static Future<String> get getstorageToken async =>
      await _storage.read(key: 'token');

  String get getUsername => _username;

  String get getToken => _token;

  removeToken() async {
    _token = null;
    await _storage.deleteAll();
  }

  Future<bool> signUpUser(String username, String password) async {
    bool check = false;
    try {
      var data = {'username': username, 'password': password};
      String jsonData = json.encode(data);
      var response = await CallApi().postData(jsonData, 'users');
      final Map<String, dynamic> body = json.decode(response.body);
      if (response.statusCode == 201) {
        _uid = body['id'];
        _username = body['username'];
        await _storage.write(key: 'token', value: body['token']);
        notifyListeners();
        return check = true;
      }
    } catch (e) {
      print(e);
    }
    return check;
  }

  Future<bool> loginUser(String username, String password) async {
    bool check = false;
    try {
      var data = {'username': username, 'password': password};
      var response = await CallApi().postData(data, 'users/user');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        this._uid = body['id'];
        this._username = body['username'];
        await _storage.write(key: 'token', value: body['token']);
        _token = await _storage.read(key: 'token');
        notifyListeners();
        return check = true;
      }
    } catch (e) {
      print(e);
    }
    return check;
  }

  Future<bool> registerUser(String username, String password) async {
    bool check = false;
    try {
      var data = {'username': username, 'password': password};
      var response = await CallApi().postData(data, 'users');
      final Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        this._uid = body['id'];
        this._username = body['username'];
        await _storage.write(key: 'token', value: body['token']);
        _token = await _storage.read(key: 'token');
        notifyListeners();
        return check = true;
      }
    } catch (e) {
      print(e);
    }
    return check;
  }
}
