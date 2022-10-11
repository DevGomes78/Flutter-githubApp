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

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller = context.read<ApiMyProject>();
    controller2 = context.read<ApiRepository>();

    controller.getMyProject();
    controller2.getFolowing();
  }

  @override
  Widget build(BuildContext context) {
    ApiMyProject provider = Provider.of<ApiMyProject>(context);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          const TopBar(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 20,
              child: Row(
                children: const [
                  Icon(
                    Icons.star_border,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 15),
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
          SizedBox(height: 10),
          Container(
            height: 160,
            width: double.infinity,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: provider.list.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
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
                                SizedBox(width: 10),
                                Text(
                                  provider.list[index].owner!.login.toString(),
                                  style: TextStyle(
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
                                const Icon(Icons.star,color: Colors.yellow,),
                                const SizedBox(width: 10,),
                                Text(provider.list[index].stargazersCount.toString()),
                                const SizedBox(width: 15,),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.lightBlue
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(provider.list[index].language.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
