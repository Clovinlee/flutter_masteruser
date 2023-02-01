// ignore_for_file: must_be_immutable

import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/homepage.dart';
import 'package:c_masteruser/pages/masterpage.dart';
import 'package:c_masteruser/pages/profilepage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';

class WrapperPage extends StatefulWidget {
  WrapperPage({required this.user, super.key});

  final User user;
  late List<Widget> pageList;

  @override
  State<WrapperPage> createState() => _WrapperPageState();

  int idxPage = 0;
}

class _WrapperPageState extends State<WrapperPage> {
  @override
  void initState() {
    widget.pageList = [
      HomePage(user: widget.user),
      ProfilePage(user: widget.user),
      MasterPage(user: widget.user),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: ((context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          })),
          backgroundColor: ThemeManager.darkSecondaryColor,
          title: Text(
            "Home",
            style: txtTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
        ),
        drawer: HomeDrawer(widget: widget, txtTheme: txtTheme),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.idxPage,
          onTap: (int idx) {
            setState(() {
              widget.idxPage = idx;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                ),
                label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                ),
                label: "Master")
          ],
        ),
        body: widget.pageList[widget.idxPage]);
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.widget,
    required this.txtTheme,
  }) : super(key: key);

  final WrapperPage widget;
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
