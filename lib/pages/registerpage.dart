import 'package:c_masteruser/pages/loginpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: ThemeManager.primaryAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register Page"),
            ElevatedButton(
                onPressed: () {
                  Route loginRoute =
                      MaterialPageRoute(builder: ((context) => LoginPage()));
                  Navigator.of(context).pushReplacement(loginRoute);
                },
                child: Text("Go To Login! (THIS REPLACE ROUTE)"))
          ],
        ),
      ),
    );
  }
}
