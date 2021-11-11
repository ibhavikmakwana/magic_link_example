import 'package:flutter/material.dart';
import 'package:magic_link_example/splash_screen.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_sdk/modules/user/user_response_type.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Magic magic = Magic.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              final doLogOut = await magic.user.logout();
              if (doLogOut) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (_) => false,
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<UserMetadata>(
        future: magic.user.getMetadata(),
        builder: (_, userMeta) {
          if (userMeta.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${userMeta.data?.email}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Issuer:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${userMeta.data?.issuer}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Public Address:',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    '${userMeta.data?.publicAddress}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          } else if (userMeta.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text('${userMeta.error}'),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
