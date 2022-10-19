import 'package:flutter/material.dart';
import 'package:flutter_github_app/constants/service_constants.dart';
import 'package:flutter_github_app/pages/repository_list_page.dart';
import '../components/bottonnavigationBar.dart';
import '../components/top_bar.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/string_constants.dart';
import '../controller/repository_controller.dart';
import '../controller/user_controller.dart';
import '../controller/call_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  RepositoryController controller = RepositoryController();

  @override
  void initState() {
    controller = context.read<RepositoryController>();

    controller.getPopular();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerRepository = Provider.of<RepositoryController>(context);

    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: UserController().getUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Container(
                  color: Colors.transparent,
                ));
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(ErrorConstants.errorPage),
                  );
                } else {
                  return Column(
                    children: [
                      const TopBar(),
                      const SizedBox(height: 10),
                      _textPopular(),
                      const SizedBox(height: 15),
                      providerRepository.list.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : _listRepository(providerRepository),
                      const SizedBox(width: 10),
                      _cardInfos(context, snapshot),
                    ],
                  );
                }
            }
          },
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }
}

_cardInfos(BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
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
                              builder: (context) => const RepositoryList()));
                    },
                    child: const Text(
                      StringConstants.repository,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 150),
                  Text(
                      snapshot.data![ServiceConstants.publicRepository]
                          .toString(),
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.dataset_outlined, color: Colors.orange),
                  SizedBox(width: 20),
                  Text(
                    StringConstants.organizations,
                    style: TextStyle(fontSize: 20, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, color: Colors.white),
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

_listRepository(RepositoryController providerRepository) {
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
                        const SizedBox(height: 8),
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

_textPopular() {
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
