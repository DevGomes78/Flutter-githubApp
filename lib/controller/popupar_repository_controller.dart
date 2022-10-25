import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/error_constants.dart';
import '../models/repository_model.dart';

class PopularRepositoryController extends ChangeNotifier {
  List<RepositoyModels> list = [];

  Future<List<RepositoyModels>> getPopular(String? user) async {
    try {
      var url = Uri.parse('https://api.github.com/users/$user/repos');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => list.add(RepositoyModels.fromJson(item)));
        list = list.where((item) => item.stargazersCount! >= 1).toList();
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
