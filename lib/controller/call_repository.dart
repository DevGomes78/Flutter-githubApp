
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_github_app/models/repository_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CallRepository extends StatelessWidget {
  RepositoyModels repositoyModels;
  CallRepository({Key? key, required this.repositoyModels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void callGithub() async {
    if (await launch(repositoyModels.htmlUrl.toString())) {
      await launch(
        repositoyModels.htmlUrl.toString(),
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw 'Could not launch $repositoyModels.htmlUrl.toString()';
    }
  }
}