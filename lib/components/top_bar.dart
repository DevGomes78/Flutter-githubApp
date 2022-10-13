import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/string_constants.dart';
import 'package:provider/provider.dart';
import '../controller/followers_api_controller.dart';
import '../controller/api_user_controller.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late final ApiUserController apiUserController;
  late final ApiFolowers apiFolowers;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    apiUserController = context.read<ApiUserController>();
    apiFolowers = context.read<ApiFolowers>();

    apiUserController.getUser();
    apiFolowers.getFolowing();
  }

  @override
  Widget build(BuildContext context) {
    ApiUserController userProvider = Provider.of<ApiUserController>(context);
    ApiFolowers userFolowers = Provider.of<ApiFolowers>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                    userProvider.decodeJson['avatar_url'],
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 80,
                child: Text(
                  userProvider.decodeJson['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 110,
                child: Text(
                  userProvider.decodeJson['login'],
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white54,
                  ),
                ),
              ),
              const Positioned(
                left: 15,
                top: 150,
                child: Text(
                  StringConstants.flutterDeveloper,
                  style: TextStyle(
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
                child: Text(
                  userProvider.decodeJson['blog'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 290,
                top: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 30,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.blue,
                    size: 25,
                  ),
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
                  userFolowers.list.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                left: 65,
                top: 210,
                child: Text(
                  (StringConstants.folower),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                  userProvider.decodeJson['following'].toString(),
                ),
              ),
              const Positioned(
                left: 200,
                top: 211,
                child: Text(
                  StringConstants.folowing,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
