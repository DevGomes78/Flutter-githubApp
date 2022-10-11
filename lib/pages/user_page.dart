import 'package:flutter/material.dart';
import '../components/top_bar.dart';
import 'package:provider/provider.dart';
import '../controller/api_repository.dart';
import '../controller/api_user_service.dart';
import '../controller/my_project_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final ApiMyProject controller;
  late final ApiRepository controller2;
  late final ApiController controller3;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller = context.read<ApiMyProject>();
    controller2 = context.read<ApiRepository>();
    controller3 = context.read<ApiController>();

    controller.getMyProject();
    controller2.getFolowing();
    controller3.getUser();
  }

  @override
  Widget build(BuildContext context) {
    ApiMyProject provider = Provider.of<ApiMyProject>(context);
    ApiController provider1 = Provider.of<ApiController>(context);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const TopBar(),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 25,
              child: Row(
                children: const [
                  Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 160,
              width: double.infinity,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: SizedBox(
                        height: 160,
                        width: 220,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(provider
                                        .list[index].owner!.avatarUrl
                                        .toString()),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    provider.list[index].owner!.login.toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(provider.list[index].name.toString()),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(provider.list[index].stargazersCount
                                      .toString()),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.lightBlue),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(provider.list[index].language.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.receipt,
                              size: 20, color: Colors.white),
                          const SizedBox(width: 20),
                          const Text(
                            'Repositorios',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 150),
                          Text(
                            provider1.decodeJson['public_repos'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(
                            Icons.dataset_outlined,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Organizaçoes',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 150),
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 0),
                          Text(
                            'Classificado como Estrela',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            '15',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.blueAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: ("Notificaçoes")),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ("Perfil")),
        ],
      ),
    );
  }
}
