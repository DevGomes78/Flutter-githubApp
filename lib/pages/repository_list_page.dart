import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/search_repository.dart';
import '../constants/string_constants.dart';
import '../service/repository_service.dart';
import '../controller/call_repository_controller.dart';

class RepositoryListPage extends StatefulWidget {
  String? text;

  RepositoryListPage(this.text, {Key? key}) : super(key: key);

  @override
  State<RepositoryListPage> createState() => _RepositoryListPageState();
}

class _RepositoryListPageState extends State<RepositoryListPage> {
  RepositoryController controller = RepositoryController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    controller = context.read<RepositoryController>();
    controller.getRepository(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RepositoryController>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.text.toString(),style: const TextStyle(fontSize: 14,color: Colors.grey),),
                const Text(StringConstants.repository),
              ],
            )),
        backgroundColor: Colors.black12,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search,color: Colors.blue),
          ),
        ],
      ),
      body: provider.list.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _repositoryList(provider),
    );
  }

  _appBarContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12,
      ),
      child: TextField(
        onTap: () {
          showSearch(
            context: context,
            delegate: SearchRepository(),
          );
        },
        decoration: const InputDecoration(
          labelText: StringConstants.searchRepository,
        ),
      ),
    );
  }

  _repositoryList(provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: ListView.builder(
          itemCount: provider.list.length,
          itemBuilder: (context, index) {
            var listRepository = provider.list[index];
            return InkWell(
              onTap: CallRepository(repositoyModels: listRepository).callGithub,
              child: Card(
                elevation: 5,
                child: SizedBox(
                  height: 110,
                  width: 220,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listRepository.name.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          listRepository.description.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
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
    );
  }
}
