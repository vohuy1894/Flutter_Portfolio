import 'package:flutter/material.dart';
//import 'package:portfolio/pages/contact/contact.dart';
import 'package:portfolio/services/database.dart';
import '/pages/account.dart';
//import '/pages/group.dart';
import '/pages/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MenuDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User? _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final name = _currentUser!.displayName.toString();
    final email = _currentUser!.email.toString();
    final group = 'Sport';
    final urlImage =
        'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc5OTk2ODUyMTMxNzM0ODcy/gettyimages-1229892983-square.jpg';
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
            const SizedBox(
              height: 16,
            ), //contact menu
            buildMenuItem(
              text: 'Contact',
              icon: Icons.contact_phone,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 16,
            ), //Favourites menu
            buildMenuItem(
              text: 'Group',
              icon: Icons.group,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 16,
            ), //Account menu
            buildMenuItem(
              text: 'Account',
              icon: Icons.account_box,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 16,
            ), //Update app menu
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 3),
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
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: TextStyle(fontSize: 14, color: Colors.black),
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
  final color = Colors.black;
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
        builder: (context) => AccountPage(),
      ));
      break;
    case 3:
      context.read<AuthenticationService>().logOut(context);
      break;
  }
}
