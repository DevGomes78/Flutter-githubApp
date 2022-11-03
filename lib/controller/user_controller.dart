import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/error_constants.dart';

class UserController extends ChangeNotifier {
  var decodeJson;

  Future<Map<String, dynamic>> getUser(context,String user) async {
    try {
      if (user.isNotEmpty) {
        var url = Uri.parse('https://api.github.com/users/$user');
        var response = await http.get(url);
        if (response.statusCode == 200) {
          decodeJson = jsonDecode(response.body);
          notifyListeners();
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
            content: Text(ErrorConstants.userNotregister)
          ),
        );
      }
    } catch (e) {
      print('${ErrorConstants.erroAoAcessarPagina}$e');
    }
    return decodeJson;
  }
}
