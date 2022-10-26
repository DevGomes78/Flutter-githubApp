import 'package:flutter/material.dart';
import '../constants/service_constants.dart';
import '../constants/string_constants.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildCenter(),
    );
  }

  _buildCenter() {
    return Container(
      decoration: const BoxDecoration(
       color: Colors.black,
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              Image.asset(
                ServiceConstants.imageAsset,
                color: Colors.white,
                height: 180,
              ),
              const SizedBox(height: 90),
               const Text(
                StringConstants.holdUp,
                style: TextStyle(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}