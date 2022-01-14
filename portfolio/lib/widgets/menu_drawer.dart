import 'package:flutter/material.dart';
import 'package:portfolio/pages/log_in_out/login.dart';
//import 'package:portfolio/pages/contact/contact.dart';
import '/pages/account.dart';
//import '/pages/group.dart';
import '/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:portfolio/pages/wishlist/wishlist.dart';

class MenuDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User? _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

    final name = _currentUser!.displayName.toString();
    final email = _currentUser!.providerData[0].email.toString();
    final group = 'Sport';
    final urlImage =
        _currentUser!.photoURL.toString();
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            //Contain list of menu items
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: name,
                  urlImage: urlImage,
                  group: group,
                ),
              )),
            ),
            const SizedBox(height: 10), //contact menu
            buildMenuItem(
              text: 'Contact',
              icon: Icons.contact_phone,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 0,
            ), //Favourites menu
            buildMenuItem(
              text: 'History',
              icon: Icons.history,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 10,
            ), //Account menu
            buildMenuItem(
              text: 'Wish Lists',
              icon: Icons.favorite,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 24,
            ),
            Divider(
              color: primaryColor,
            ),
            const SizedBox(
              height: 16,
            ),
            //Update app menu
            ListTile(
              leading: Icon(
                Icons.logout,
                color: primaryColor,
              ),
              title: Text("Log out", style: TextStyle(color: primaryColor)),
              hoverColor: Colors.red,
              onTap: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                final FacebookAuth result = FacebookAuth.instance;
                //await FacebookAuth.instance.logOut();
                await FirebaseAuth.instance.signOut();
                await googleSignIn.signOut();
                await result.logOut();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader({
  required String urlImage,
  required String name,
  required String email,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: Row(
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(urlImage)),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 20, color: primaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(fontSize: 14, color: primaryColor),
              ),
            ],
          ),
          Spacer(),
          // CircleAvatar(
          //   radius: 30,
          //   backgroundColor: Colors.black,
          //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
          // )
        ],
      ),
    );
Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = primaryColor;
  final hoverColor = Colors.red;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop(); //Close the menu after going back.

  //Direct each page after user clicks on
  //Change the page before use
  switch (index) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccountPage(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AccountPage(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => WishListPage(),
      ));
      break;
    
  }
}
