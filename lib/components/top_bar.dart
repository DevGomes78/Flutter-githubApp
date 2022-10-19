import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:flutter_github_app/controller/call_linkedin.dart';
import 'package:flutter_github_app/pages/folowers_page.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../controller/user_controller.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  UserController userController = UserController();

  @override
  void initState() {
    userController = context.read<UserController>();
    userController.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserController provider = Provider.of<UserController>(context);

    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder<Map<String, dynamic>>(
            future: UserController().getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return  const Center(
                      child: Text(ErrorConstants.errorPage),
                    );
                  } else {
                    return Card(
                      elevation: 5,
                      child: Container(
                        height: 270,
                        alignment: Alignment.bottomCenter,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black26,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 70,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  provider.decodeJson['avatar_url'],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 100,
                              top: 80,
                              child: Text(
                                provider.decodeJson['name'],
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Positioned(
                              left: 100,
                              top: 110,
                              child: Text(
                                provider.decodeJson['login'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 15,
                              top: 150,
                              child: Text(
                                provider.decodeJson['bio'].toString(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Positioned(
                              left: 15,
                              top: 180,
                              child: Icon(
                                Icons.link,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                            Positioned(
                              left: 35,
                              top: 182,
                              child: InkWell(
                                onTap: const CallLinkedin().callLinkedin,
                                child: Text(
                                  provider.decodeJson['blog'],
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 290,
                              top: 30,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.share,
                                    color: Colors.blue, size: 25),
                              ),
                            ),
                            Positioned(
                              left: 330,
                              top: 30,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.settings,
                                    color: Colors.blue, size: 25),
                              ),
                            ),
                            const Positioned(
                              left: 15,
                              top: 208,
                              child: Icon(
                                Icons.person_outline_rounded,
                                color: Colors.white54,
                                size: 20,
                              ),
                            ),
                            Positioned(
                              left: 45,
                              top: 210,
                              child: Text(
                                provider.decodeJson['followers'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 65,
                              top: 210,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FolowersPage()));
                                },
                                child: const Text(
                                  (StringConstants.folower),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 145,
                              top: 215,
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
                              top: 211,
                              child: Text(
                                provider.decodeJson['following'].toString(),
                              ),
                            ),
                            const Positioned(
                              left: 200,
                              top: 211,
                              child: Text(
                                StringConstants.folowing,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              }
            }));
  }
}
