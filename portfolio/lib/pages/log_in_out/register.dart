import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/log_in_out/verify.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:portfolio/services/fire_auth.dart';
import 'package:portfolio/widgets/primary_button.dart';
import 'package:portfolio/pages/content/content.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}
class _SignUp extends State<SignUp> {
  final _nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _registerkey = GlobalKey<FormState>();
  String _loginError =  '';
  final _isProcessing = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Form(
            key: _registerkey,
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
                    controller: _nameController,
                    cursorColor: primaryColor,
                    validator: (value) {
                      if(value == null || value.isEmpty)
                      {
                        return "Please enter your name here";
                      }
                      return null;
          
                    },
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: primaryColor,
                      ),
                      hintText: "Your Name",
                      //border: InputBorder.none,
                    ),
                  ),
                TextFormField(
                  controller: emailController,
                  cursorColor: primaryColor,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                    {
                      return "Please enter your email here";
                    }
                    return null;
                  },
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
                  obscureText: true,
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
                  text: "Sign Up",
                  color: primaryColor,
                  press: () async {
                    if(_registerkey.currentState!.validate())
                    {
                      String message = await FireAuth.registerUsingEmailPassword(name: _nameController.text, email: emailController.text, password: passwordController.text);
                      print(message);
                      if (message == "Signed up")
                      {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => VerifyPage()), ModalRoute.withName('/'));
                      }else 
                      {
                        setState(() {
                          _loginError = message;
                        });
                        
                      }
                    }
                  //       context.read<AuthenticationService>().signUp(
                  //       email: emailController.text.trim(),
                  //       password: passwordController.text.trim());
                  //       Navigator.push(
                  //       context, MaterialPageRoute(builder: (_) => MapPage()));
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
                
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
