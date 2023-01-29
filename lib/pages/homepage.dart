import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/loginpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.deepOrangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Route loginRoute =
                      MaterialPageRoute(builder: ((context) => LoginPage()));
                  Navigator.of(context).pushReplacement(loginRoute);
                },
                child: Text("Logout (in a nut shell)"))
          ],
        ),
      ),
    );
  }
}
