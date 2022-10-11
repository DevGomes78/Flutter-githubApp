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
            TopBar(),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.4,
              child:
                  Stack(
                    children: const [
                      Positioned(
                        left: 15,
                        child: Icon(
                          Icons.star_border,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 5,
                        child: Text(
                          'Popular',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),



              
            ),
          ],
        ));
  }
}
