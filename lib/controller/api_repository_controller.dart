import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../constants/error_constants.dart';
import '../constants/service_constants.dart';
import '../models/repository_model.dart';

class ApiRepository extends ChangeNotifier {
  List<RepositoyModels> list = [];

  Future<List<RepositoyModels>> getFolowing() async {
    try {
      var url = Uri.parse(ServiceConstants.apiRepository);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => list.add(RepositoyModels.fromJson(item)));
        notifyListeners();
        return list;
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');
      return [];
    }
    return [];
  }
}
