// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/user/addpage,.dart';
import 'package:c_masteruser/utils/page_change.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class MasterPage extends StatefulWidget {
  MasterPage({required this.user, super.key});

  final User user;

  @override
  State<MasterPage> createState() => _MasterPageState();

  late Future<List<User>?> listUsers;
}

UserController userController = UserController();

class _MasterPageState extends State<MasterPage> {
  @override
  void initState() {
    widget.listUsers = userController.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Master User",
              style: txtTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "List of Users",
              style: txtTheme.bodySmall,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GradientButton(
                  gradient: Gradients.buildGradient(
                      Alignment.centerLeft,
                      Alignment.centerRight,
                      [Colors.green.shade400, Colors.green.shade500]),
                  callback: () {
                    stackNextPage(context, AddUserPage());
                  },
                  increaseWidthBy: 35,
                  increaseHeightBy: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 26,
                      ),
                      hSpace(6),
                      Text(
                        "Add User",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            vSpace(10),
            FutureBuilder(
                future: widget.listUsers,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData &&
                      snapshot.data != null) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: PaginatedDataTable(
                          source: UserDataTableSource(userData: snapshot.data!),
                          rowsPerPage: 10,
                          dataRowHeight: 100,
                          columns: const [
                            DataColumn(label: Text("#")),
                            DataColumn(label: Text("Nama")),
                            DataColumn(label: Text("Email")),
                            DataColumn(label: Text("Deskripsi")),
                          ],
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                })),
          ],
        ),
      ),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  List<User> userData;

  UserDataTableSource({required this.userData});

  @override
  DataRow? getRow(int index) {
    if (index >= userData.length) {
      return null;
    }

    final User u = userData[index];
    return DataRow(
      cells: [
        DataCell(Text(u.id.toString())),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(u.name),
            IconButton(
              splashRadius: 25,
              onPressed: () {
                //TODO: EDIT
              },
              icon: Icon(Icons.edit),
            )
          ],
        )),
        DataCell(Text(u.email)),
        DataCell(SizedBox(
            width: 150,
            child: Text(
              u.description ?? "-",
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            )))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userData.length;

  @override
  int get selectedRowCount => 0;
}
