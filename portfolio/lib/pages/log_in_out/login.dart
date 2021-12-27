import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:portfolio/services/database.dart';
import 'package:portfolio/services/fire_auth.dart';
import 'package:portfolio/widgets/primary_button.dart';
import 'package:portfolio/pages/content/content.dart';
import 'package:portfolio/pages/log_in_out/register.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/pages/log_in_out/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/services/google_sign.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final _loginKey =
      GlobalKey<FormState>(); //validator empty field with global key
  String _loginError = ''; //send login error string to ui
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified == false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VerifyPage(),
        ),
      );
    } else if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }

    return firebaseApp;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding + 50),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: [
                      Spacer(flex: 1),
                      Image.asset(
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? "assets/images/logo.png"
                            : "assets/images/Logo_dark.png",
                        height: 200,
                      ),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: primaryColor,
                          ),
                          hintText: "Your Email",
                          //border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email here';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: primaryColor,
                          ),
                          hintText: "Password",
                          //border: InputBorder.none,
                        ),
                      ),
                      // SignInButton(Buttons.Google, onPressed: () async {
                      //   try {
                      //     GoogleSignIn _googleSignIn = GoogleSignIn();
                      //     await _googleSignIn.signIn();
                      //   } catch (error) {
                      //     print(error);
                      //   }
                      // }),

                      SelectableText(
                        _loginError,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: defaultPadding * 1.5),
                      PrimaryButton(
                          text: "Log In",
                          color: primaryColor,
                          press: () async {
                            if (_loginKey.currentState!.validate()) {
                              String message =
                                  await FireAuth.signInUsingEmailPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                              print(message);
                              if (message == "Signed In") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage()));
                              } else if (message == "Not verified") {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => VerifyPage()),
                                    ModalRoute.withName('/'));
                              } else {
                                setState(() {
                                  _loginError = message;
                                });
                              }
                            }
                            // context
                            //     .read<AuthenticationService>()
                            //     .signIn(
                            //         email: emailController.text.trim(),
                            //         password: passwordController.text.trim())
                            //     .then((value) {
                            //   print("Value: " + value);

                            //   if( value != "Signed in")
                            //   {
                            //     print("Login Failed");
                            //     setState(() {
                            //       isLoading = false;
                            //       _loginError = value;
                            //     });
                            //   } else {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(content: Text('Processing Data')),
                            //     );
                            //     Navigator.push(context,
                            //         MaterialPageRoute(builder: (_) => MapPage()));
                            //     print("Account Logged In Sucessfull");
                            //     setState(() {
                            //       isLoading = false;
                            //     });
                            //   }
                            // });
                          }),
                      SizedBox(height: defaultPadding * 1.5),
                      Text(
                        'or',
                        style: TextStyle(color: primaryColor),
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: primaryColor,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.facebook,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              User? user = await FireAuth.signInWithGoogle(
                                  context: context);

                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      //ruser: user,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "assets/images/google-icon.svg",
                                  width: 24,
                                  height: 24,
                                  color: primaryColor,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding * 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don’t have an Account ? ",
                            style: TextStyle(color: primaryColor),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => SignUp())),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
