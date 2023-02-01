// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  MasterPage({required this.user, super.key});

  final User user;

  @override
  State<MasterPage> createState() => _MasterPageState();
}

UserController userController = UserController();

class _MasterPageState extends State<MasterPage> {
  @override
  void initState() {
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
            vSpace(10),
            FutureBuilder(
                future: userController.fetchUsers(),
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
              onPressed: () {},
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
