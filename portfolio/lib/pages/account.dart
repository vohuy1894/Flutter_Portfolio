import 'package:flutter/material.dart';
import 'package:portfolio/global/global_color_const.dart';
import 'package:portfolio/pages/google_ad/google_ad.dart';
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
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text('Account', style: TextStyle(color: Colors.black),),
          elevation: 0,
          //centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: Container(
          height: 548,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          
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
              ElevatedButton(onPressed: (){ Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoogleAdPage()),
                      ); }, child: Text("Click here for Ad"), style: ElevatedButton.styleFrom(primary: primaryColor),),
            ],
          ),
        ),
      );
}
