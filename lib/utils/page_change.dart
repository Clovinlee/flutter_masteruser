import 'package:c_masteruser/models/user.dart';
import 'package:flutter/material.dart';
import '../pages/homepage.dart';

void switchPage(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void stackNextPage(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
