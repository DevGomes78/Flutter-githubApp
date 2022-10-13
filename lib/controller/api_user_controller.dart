import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:http/http.dart' as http;

import '../constants/error_constants.dart';

class ApiUserController extends ChangeNotifier {
  var decodeJson;

  Future<Map<String, dynamic>?> getUser() async {
    try {
      var url = Uri.parse(ServiceConstants.apiUserController);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        decodeJson = jsonDecode(response.body);
        notifyListeners();
        return decodeJson;
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');

    }
    return null;
  }
}
