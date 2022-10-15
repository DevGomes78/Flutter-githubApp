import 'package:flutter/material.dart';
import 'package:flutter_github_app/pages/repository_list.dart';
import '../components/bottonnavigationBar.dart';
import '../components/top_bar.dart';
import 'package:provider/provider.dart';
import '../constants/string_constants.dart';
import '../controller/api_repository.dart';
import '../controller/api_user.dart';
import '../controller/call_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  ApiRepository apiRepository = ApiRepository();
  ApiUserController apiUserController = ApiUserController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    apiRepository = context.read<ApiRepository>();
    apiUserController = context.read<ApiUserController>();

    apiRepository.getRepository();
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
                ? const Center(child: CircularProgressIndicator())
                : listRepository(providerRepository),
            const SizedBox(width: 10),
            cardInfos(context, providerUserController),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  cardInfos(BuildContext context, ApiUserController providerUserController) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RepositoryList()));
                      },
                      child: const Text(
                        StringConstants.repository,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 150),
                    Text(
                      apiUserController.decodeJson['public_repos'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.dataset_outlined, color: Colors.orange),
                    SizedBox(width: 20),
                    Text(
                      StringConstants.organizations,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    SizedBox(width: 150),
                    Text(
                      '0',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.yellow),
                    SizedBox(width: 15),
                    Text(
                      StringConstants.ratedAsStar,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    SizedBox(width: 30),
                    Text(
                      '16',
                      style: TextStyle(fontSize: 18),
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
}

listRepository(ApiRepository providerRepository) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: providerRepository.list.length,
          itemBuilder: (context, index) {
            var listRepository = providerRepository.list[index];
            return InkWell(
              onTap: CallRepository(repositoyModels: listRepository).callGithub,
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 200,
                  width: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
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
                        Text(
                          listRepository.name.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(listRepository.description.toString()),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
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
              ),
            );
          }),
    ),
  );
}

textPopular() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: SizedBox(
      height: 25,
      child: Row(
        children: const [
          Icon(Icons.star_border, color: Colors.white, size: 30),
          SizedBox(width: 10),
          Text(
            StringConstants.popular,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
