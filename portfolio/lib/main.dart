

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/providers/cart_provider.dart';
import 'package:portfolio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:portfolio/providers/product_provider.dart';
import 'package:portfolio/providers/user_provider.dart';
import 'package:portfolio/providers/wishlist_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env["STRIPE_SHAREABLE_KEY"].toString();
  Stripe.merchantIdentifier = 'any string works';

  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<WishListProvider>(create: (context) => WishListProvider()),
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

