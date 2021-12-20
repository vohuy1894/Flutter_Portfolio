import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final String name;
  final String group;
  final String urlImage;

  const UserPage({
    Key? key,
    required this.name,
    required this.group,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(name),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(urlImage),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                Text(
                  'Name: ' + name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 4),
                Text(
                  'Group: ' + group,
                  style: TextStyle(color: Colors.grey, fontSize: 25),
                )
              ],
            ),
          ],
        ),
      );
}
