// ignore_for_file: use_build_context_synchronously

import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/loginpage.dart';
import 'package:c_masteruser/pages/wrapperpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/page_change.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.user, super.key, required this.btmBarKey});

  final User user;
  final GlobalKey btmBarKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ThemeManager.secondaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: txtTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.user.name,
                      style: txtTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GradientButton(
                          increaseWidthBy: 20,
                          increaseHeightBy: 2,
                          gradient: Gradients.buildGradient(
                              Alignment.centerLeft,
                              Alignment.centerRight,
                              [Colors.red.shade700, Colors.red.shade400]),
                          callback: () {
                            logout(context);
                          },
                          child: Text(
                            "Logout",
                            style: txtTheme.bodyLarge
                                ?.copyWith(color: ThemeManager.whiteColor),
                          ),
                        ),
                        hSpace(10),
                        GradientButton(
                          increaseWidthBy: 20,
                          increaseHeightBy: 2,
                          gradient: Gradients.buildGradient(
                              Alignment.centerLeft,
                              Alignment.centerRight,
                              [Colors.orange.shade600, Colors.orange.shade400]),
                          callback: () {
                            final BottomNavigationBar btmBar =
                                btmBarKey.currentWidget as BottomNavigationBar;
                            btmBar.onTap!(1);
                          },
                          child: Text(
                            "My Profile",
                            style: txtTheme.bodyLarge
                                ?.copyWith(color: ThemeManager.whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 45,
                  foregroundImage: AssetImage("assets/images/man.png"),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            color: ThemeManager.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: txtTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Useful insight of application",
                  style: txtTheme.bodySmall,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  switchPage(context, LoginPage());
}
