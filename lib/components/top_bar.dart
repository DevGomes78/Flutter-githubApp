import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/api_folowers.dart';
import '../controller/api_user_service.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late final ApiController controller;
  late final ApiFolowers controller2;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller = context.read<ApiController>();
    controller2 = context.read<ApiFolowers>();

    controller.getUser();
    controller2.getFolowing();
  }

  @override
  Widget build(BuildContext context) {
    ApiController provider = Provider.of<ApiController>(context);
    ApiFolowers folowers = Provider.of<ApiFolowers>(context);
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
                  color: Colors.white,
                ),
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
            const Positioned(
              left: 15,
              top: 150,
              child: Text(
                'Desenvolvedor Flutter',
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
                provider.decodeJson['blog'],
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 240,
              top: 20,
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
              left: 280,
              top: 20,
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
                folowers.list.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 65,
              top: 210,
              child: Text(
                ('Seguidor'),
                style: const TextStyle(
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
                child: Text(provider.decodeJson['following'].toString())),
            Positioned(
              left: 200,
              top: 211,
              child: Text(
                'Seguindo',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
