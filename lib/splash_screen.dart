import 'package:flutter/material.dart';
import 'package:magic_sdk/magic_sdk.dart';

import 'login_screen.dart';
import 'my_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Magic magic = Magic.instance;

  @override
  void initState() {
    super.initState();
    manageNavigation();
  }

  Future<void> manageNavigation() async {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        magic.user.isLoggedIn().then((isLoggedIn) {
          if (isLoggedIn) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => const MyHomePage(title: 'Home')),
              (_) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            );
          }
        }).onError((error, stackTrace) {
          debugPrint('error: $error\nstackTrace: $stackTrace');
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
