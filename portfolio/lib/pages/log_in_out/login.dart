import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/map.dart';
import 'package:portfolio/services/database.dart';
import 'package:portfolio/widgets/primary_button.dart';
import 'package:portfolio/pages/content/content.dart';
import 'package:portfolio/pages/log_in_out/register.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final _formGlobalKey = GlobalKey<FormState>(); //validator empty field with global key
  String _loginError = ''; //send login error string to ui
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding + 50),
          child: Form(
            key: _formGlobalKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) { 
                      return 'Please enter email here';
                    }
                    return null;
                  },
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
                SelectableText(
                      _loginError,
                      style: TextStyle(color: Colors.red),
                    ),
                SizedBox(height: defaultPadding * 1.5),
                
                PrimaryButton(
                    text: "Log In",
                    color: primaryColor,
                    press: () {
                      context
                          .read<AuthenticationService>()
                          .signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim())
                          .then((value) {
                        print("Value: " + value);
                        
                        
                        if( value != "Signed in")
                        {
                          print("Login Failed");
                          setState(() {
                            isLoading = false;
                            _loginError = value;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => MapPage()));
                          print("Account Logged In Sucessfull");
                          setState(() {
                            isLoading = false;
                          });
                        }
                      });
                    }),
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
                          MaterialPageRoute(builder: (context) => SignUp())),
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
      ),
    );
  }
}
