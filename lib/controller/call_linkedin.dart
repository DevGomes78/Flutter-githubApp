import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/error_constants.dart';
import '../constants/service_constants.dart';

class CallLinkedin extends StatelessWidget {
  const CallLinkedin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void callLinkedin() async {
    if (await launch(ServiceConstants.htmlUrl)) {
      await launch(
        ServiceConstants.htmlUrl,
        enableJavaScript: true,
        forceWebView: true,
      );
    } else {
      throw ErrorConstants.erroAoAcessarPagina;
    }
  }
}
