import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:flutter_github_app/controller/call_linkedin.dart';
import 'package:flutter_github_app/pages/folowers_page.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../controller/user_controller.dart';

class TopCard extends StatefulWidget {
  String? text;

  TopCard(this.text, {Key? key}) : super(key: key);

  @override
  State<TopCard> createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  UserController userController = UserController();

  @override
  void initState() {
    userController = context.read<UserController>();
    userController.getUser(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FutureBuilder<Map<String, dynamic>>(
        future: userController.getUser(widget.text),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(ErrorConstants.errorPage),
                );
              } else {
                return _topCard(context);
              }
          }
        },
      ),
    );
  }

  _topCard(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 300,
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        color: Colors.black26,
        child: Stack(
          children: [
            Positioned(
              left: 15,
              top: 100,
              child: CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                  userController.decodeJson[ServiceConstants.avatarUrl],
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 110,
              child: Text(
                userController.decodeJson[ServiceConstants.name],
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Positioned(
              left: 100,
              top: 140,
              child: Text(
                userController.decodeJson[ServiceConstants.login],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white54,
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 180,
              child: Text(
                userController.decodeJson[ServiceConstants.bio],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const Positioned(
              left: 15,
              top: 220,
              child: Icon(
                Icons.link,
                color: Colors.grey,
                size: 18,
              ),
            ),
            Positioned(
              left: 45,
              top: 223,
              child: InkWell(
                onTap: const CallLinkedin().callLinkedin,
                child: Text(
                  userController.decodeJson[ServiceConstants.blog],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 290,
              top: 30,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share, color: Colors.blue, size: 25),
              ),
            ),
            Positioned(
              left: 335,
              top: 30,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, color: Colors.blue, size: 25),
              ),
            ),
            const Positioned(
              left: 15,
              top: 248,
              child: Icon(
                Icons.person_outline_rounded,
                color: Colors.white54,
                size: 20,
              ),
            ),
            Positioned(
              left: 45,
              top: 250,
              child: Text(
                userController.decodeJson[ServiceConstants.followers].toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 65,
              top: 250,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FolowersPage(widget.text)));
                },
                child: const Text(
                  (StringConstants.folower),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              left: 153,
              top: 255,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 170,
              top: 251,
              child: Text(
                userController.decodeJson[ServiceConstants.following].toString(),
              ),
            ),
            const Positioned(
              left: 200,
              top: 251,
              child: Text(
                StringConstants.folowing,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
