import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:http/http.dart' as http;


class ApiUserController extends ChangeNotifier{
  var baseUrl = ServiceConstants.apiUserController;
  var decodeJson;

  Future <Map<String,dynamic>> getUser()async{
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    if(response.statusCode==200){
       decodeJson = jsonDecode(response.body);
     notifyListeners();
  return decodeJson;
    } else {
      throw Exception('erro');
    }
    }

  }
