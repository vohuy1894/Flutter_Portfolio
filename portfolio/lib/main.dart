

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:portfolio/pages/log_in_out/verify.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
          initialData: "Portfolio",
        ),
      ],child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: <String,WidgetBuilder>{
          '/': (context) => AnimatedSplashScreen(splash: Image.asset('assets/images/logo.png',), nextScreen: SignIn(), duration: 3000, splashIconSize: double.infinity,splashTransition: SplashTransition.fadeTransition,),
          '/home': (context) => HomePage()
        },
    ),);
  }
}

