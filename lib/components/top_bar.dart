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
    return Container(
      height: 230,
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      color: Colors.black87,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 50,
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                provider.decodeJson['avatar_url'],
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 60,
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
            top: 90,
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
            top: 130,
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
            top: 160,
            child: Icon(
              Icons.link,
              color: Colors.grey,
              size: 18,
            ),
          ),
          Positioned(
            left: 35,
            top: 162,
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
            top: 185,
            child: Icon(
              Icons.person_outline_rounded,
              color: Colors.white54,
              size: 20,
            ),
          ),
          Positioned(
            left: 45,
            top: 185,
            child: Text(
              folowers.list.length.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 65,
            top: 185,
            child: Text(
              ('Seguidor'),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
