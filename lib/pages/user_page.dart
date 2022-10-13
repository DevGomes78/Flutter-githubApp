import 'package:flutter/material.dart';
import '../components/top_bar.dart';
import 'package:provider/provider.dart';
import '../constants/string_constants.dart';
import '../controller/api_repository_controller.dart';
import '../controller/api_user_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final ApiRepository apiRepository;
  late final ApiUserController apiUserController;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    apiRepository = context.read<ApiRepository>();
    apiUserController = context.read<ApiUserController>();

    apiRepository.getFolowing();
    apiUserController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    ApiRepository providerRepository = Provider.of<ApiRepository>(context);
    ApiUserController providerUserController =
        Provider.of<ApiUserController>(context);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TopBar(),
            const SizedBox(height: 10),
            textPopular(),
            const SizedBox(height: 15),
            providerRepository.list.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : listRepository(providerRepository),
            const SizedBox(width: 10),
            cardInfos(context, providerUserController),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      fixedColor: Colors.blueAccent,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: (StringConstants.home)),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: (StringConstants.notifications)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), label: (StringConstants.profile)),
      ],
    );
  }

  cardInfos(BuildContext context, ApiUserController providerUserController) {
    return Padding(
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
                    const Icon(
                      Icons.receipt,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      StringConstants.repository,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 150),
                    Text(
                      providerUserController.decodeJson['public_repos']
                          .toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(
                      Icons.dataset_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 20),
                    Text(
                      StringConstants.organizations,
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
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 0),
                    Text(
                      StringConstants.ratedAsStar,
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
    );
  }

  listRepository(ApiRepository providerRepository) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: providerRepository.list.length,
            itemBuilder: (context, index) {
              var listRepository = providerRepository.list[index];
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
                              backgroundImage: NetworkImage(
                                  listRepository.owner!.avatarUrl.toString()),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              listRepository.owner!.login.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(listRepository.name.toString()),
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
                            Text(listRepository.stargazersCount.toString()),
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
                            Text(listRepository.language.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  textPopular() {
    return Padding(
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
              StringConstants.popular,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
