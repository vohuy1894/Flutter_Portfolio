import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
import 'package:portfolio/services/fire_auth.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/home.dart';

class VerifyPage extends StatefulWidget {
  // final String user;

  // const VerifyPage({required this.user});

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  User? _currentUser = FirebaseAuth.instance.currentUser;

  // @override
  // void initState() {
  //   //_currentUser = User(widget.user);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hi, ${_currentUser!.displayName}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0),
              Text(
                'We sent email verification to your email: ${_currentUser!.email}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: 16.0),
              _currentUser!.emailVerified
                  ? Text(
                      'Email verified',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.green),
                    )
                  : Text(
                      'If you are not received the verification email, Please click on Verify email button',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red),
                    ),
              SizedBox(height: 16.0),
              _isSendingVerification
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isSendingVerification = true;
                            });
                            await _currentUser!.sendEmailVerification();
                            setState(() {
                              _isSendingVerification = false;
                            });
                          },
                          child: Text('Verify email'),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () async {
                            User? user =
                                await FireAuth.refreshUser(_currentUser!);

                            if (user != null) {
                              setState(() {
                                _currentUser = user;
                              });
                            }
                            if (user != null && user.emailVerified == true) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
              SizedBox(height: 16.0),
              _isSigningOut
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isSigningOut = true;
                        });
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          _isSigningOut = false;
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Text('Sign out'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
