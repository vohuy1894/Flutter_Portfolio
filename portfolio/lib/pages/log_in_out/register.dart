import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/map.dart';
import 'package:portfolio/services/database.dart';
import 'package:portfolio/widgets/primary_button.dart';
import 'package:portfolio/pages/content/content.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding + 50),
          child: Column(
            children: [
              Spacer(flex: 1),
              Image.asset(
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? "assets/images/logo.png"
                    : "assets/images/Logo_dark.png",
                height: 200,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: primaryColor,
                  ),
                  hintText: "Your Email",
                  //border: InputBorder.none,
                ),
              ),
              TextFormField(
                controller: passwordController,
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
              SizedBox(height: defaultPadding * 1.5),
              PrimaryButton(
                text: "Sign Up",
                color: primaryColor,
                press: () {context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                      Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MapPage()));
                }
              ),
              SizedBox(height: defaultPadding * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already Have an Account ",
                    style: TextStyle(color: primaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignIn())),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: defaultPadding ),
              Text('or'),
              SizedBox(height: defaultPadding ),
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
                      child: Image.asset("assets/images/google-icon.png", width: 24, height: 24,)
                    ),
                  ),
                  
                ],
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
