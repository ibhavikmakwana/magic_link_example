import 'package:flutter/material.dart';
import 'package:magic_link_example/splash_screen.dart';
import 'package:magic_sdk/magic_sdk.dart';

void main() {
  runApp(const MyApp());
  // TODO: Just add you magic Api key here and you are good to go
  Magic.instance = Magic('');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Magic Link',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: [
          const MaterialApp(
            home: SplashScreen(),
          ),
          Magic.instance.relayer,
        ],
      ),
    );
  }
}
