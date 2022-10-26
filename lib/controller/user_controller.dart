import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/error_constants.dart';

class UserController extends ChangeNotifier {
  var decodeJson;

  Future<Map<String, dynamic>> getUser(String? user) async {
    try {
      var url = Uri.parse('https://api.github.com/users/$user');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        decodeJson = jsonDecode(response.body);
        notifyListeners();
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');
    }
    return decodeJson;
  }
}
