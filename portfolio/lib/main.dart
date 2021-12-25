import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/pages/home.dart';
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
        },
    ),);
  }
}

// ß
// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   PageController _pageController = PageController();
//   List<Widget> _screen = [
//     Map(),
//     Event(),
//     Invite(),
//   ];
//   void _onPageChanged(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     _pageController.jumpToPage(index);
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: PageView(
//           controller: _pageController,
//           children: _screen,
//           onPageChanged: _onPageChanged,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.map),
//                 label: 'Map',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.event),
//                 label: 'Event',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.insert_invitation_outlined),
//                 label: 'Invite',
//               ),
//             ],
//             currentIndex: _selectedIndex,
//             selectedItemColor: Colors.green,
//             onTap: _onItemTapped),
//       );
// }
