import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as htpp;

class CallApi {
  final String _url = "https://games-reviews-coursework.herokuapp.com/";

  postData(data, endpoint) async {
    var fullUrl = _url + endpoint;
    print("my full URL is");
    print(fullUrl);
    return await htpp.post(Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
  }
}
