// ignore_for_file: use_build_context_synchronously

import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/loginpage.dart';
import 'package:c_masteruser/pages/splashpage.dart';
import 'package:c_masteruser/pages/wrapperpage.dart';
import 'package:c_masteruser/utils/page_change.dart';
import 'package:flutter/material.dart';

class WrapperMain extends StatefulWidget {
  const WrapperMain({super.key});

  @override
  State<WrapperMain> createState() => _WrapperMainState();
}

UserController userController = UserController();

class _WrapperMainState extends State<WrapperMain> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2));
      getRememberMe(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}

getRememberMe(BuildContext ctx) async {
  User? userReturn = await userController.getRememberMe();
  if (userReturn == null) {
    switchPage(ctx, LoginPage());
  } else {
    switchPage(ctx, WrapperPage(user: userReturn));
  }
}
