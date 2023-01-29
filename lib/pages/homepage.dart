import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/loginpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/page_change.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.user, super.key});

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: HomeDrawer(widget: widget, txtTheme: txtTheme),
        body: SafeArea(
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
                                switchPage(context, LoginPage());
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
                                  Alignment.centerLeft, Alignment.centerRight, [
                                Colors.orange.shade600,
                                Colors.orange.shade400
                              ]),
                              callback: () {
                                switchPage(context, LoginPage());
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
                      "User List",
                      style: txtTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "List of users in database",
                      style: txtTheme.bodySmall,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.widget,
    required this.txtTheme,
  }) : super(key: key);

  final HomePage widget;
  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ThemeManager.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    foregroundImage: AssetImage("assets/images/man.png"),
                  ),
                ),
                vSpace(15),
                Container(
                  decoration: BoxDecoration(
                      color: ThemeManager.secondaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(1, 3),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      widget.user.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: txtTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: const Text("Menu 1"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Menu 2"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Menu 3"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
