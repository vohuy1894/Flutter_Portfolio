import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/home/home.dart';
import 'package:portfolio/pages/spend_save.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget customListTile(
      {required IconData icon, required String title, VoidCallback? press}) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: press,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: Container(
          height: 548,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          // decoration: BoxDecoration(
          //   //color: primaryColor,
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(30),
          //     topRight: Radius.circular(30),
          //   ),
          // ),
          child: ListView(
            children: [
              customListTile(icon: Icons.person, title: "Profile"),
              customListTile(
                  icon: Icons.person,
                  title: "Spending&Saving",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SpendSavePage()));
                  }),
              customListTile(icon: Icons.person, title: "Policy"),
            ],
          ),
        ),
      );
}
