import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:remotediscuss/src/app.dart';
import 'package:remotediscuss/src/appwrite/auth.dart';
import 'package:remotediscuss/views/login/login.dart';

Future main() async {
  await dotenv.load(fileName: kDebugMode ? '.env.local' : '.env.prod');
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthAPI()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Remote Discuss | Quadropic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: value == AuthStatus.authenticated
          ? const MyHomePage()
          : const LoginPage(),
    );
  }
}
