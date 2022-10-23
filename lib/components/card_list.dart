import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/call_repository.dart';
import '../controller/popupar_repository_controller.dart';

class ListRepository extends StatefulWidget {
  const ListRepository({
    Key? key,
  }) : super(key: key);

  @override
  State<ListRepository> createState() => _ListRepositoryState();
}

class _ListRepositoryState extends State<ListRepository> {
  PopularRepositoryController controller = PopularRepositoryController();

  @override
  void initState() {
    controller = context.read<PopularRepositoryController>();

    controller.getPopular();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PopularRepositoryController providerRepository = Provider.of<PopularRepositoryController>(context);
    if (providerRepository.list.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: providerRepository.list.length,
              itemBuilder: (context, index) {
                var listRepository = providerRepository.list[index];
                return InkWell(
                  onTap: CallRepository(repositoyModels: listRepository)
                      .callGithub,
                  child: Card(
                    elevation: 5,
                    child: SizedBox(
                      height: 230,
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(listRepository
                                      .owner!.avatarUrl
                                      .toString()),
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
                            const SizedBox(height: 25),
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
  }
}
