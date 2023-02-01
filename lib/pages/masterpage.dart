// ignore_for_file: must_be_immutable

import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';

class MasterPage extends StatefulWidget {
  MasterPage({required this.user, super.key});

  final User user;

  @override
  State<MasterPage> createState() => _MasterPageState();

  List<UserRowData>? listUsersRowData;
  int _currentSortColumn = 0;
  bool _isAscending = true;
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
            Expanded(
              child: InteractiveViewer(
                scaleEnabled: false,
                constrained: false,
                child: DataTable(
                  border: TableBorder.all(
                    color: ThemeManager.primaryAccent,
                    borderRadius: BorderRadius.circular(10),
                    width: 3,
                  ),
                  sortAscending: widget._isAscending,
                  sortColumnIndex: widget._currentSortColumn,
                  columnSpacing: 30,
                  columns: [
                    DataColumn(
                        label: Text("#"),
                        numeric: true,
                        onSort: ((columnIndex, ascending) {
                          setState(() {
                            widget._currentSortColumn = columnIndex;
                            widget._isAscending = ascending;
                            if (ascending) {
                              widget.listUsersRowData!.sort(((a, b) {
                                a.id.compareTo(b.id);
                                return 0;
                              }));
                            } else {
                              widget.listUsersRowData!.sort(((b, a) {
                                a.id.compareTo(b.id);
                                return 0;
                              }));
                            }
                          });
                        })),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Description")),
                  ],
                  rows: [
                    for (int i = 0; i < widget.listUsersRowData!.length; i++)
                      DataRow(cells: [
                        DataCell(
                            Text(widget.listUsersRowData![i].id.toString())),
                        DataCell(Text(widget.listUsersRowData![i].user.name)),
                        DataCell(Text(widget.listUsersRowData![i].user.email)),
                        DataCell(SizedBox(
                            width: 200,
                            child: Text(
                              widget.listUsersRowData![i].user.description ??
                                  "",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ))),
                      ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRowData {
  int id;
  User user;

  UserRowData({required this.id, required this.user});
}

Future<List<UserRowData>?> loadUsers() async {
  List<User>? listUsers;
  List<UserRowData>? listUserRowData;
  UserController userController = UserController();
  listUsers = await userController.fetchUsers();
  int ctr = 1;
  listUserRowData?.forEach((element) {
    ctr++;
    listUserRowData.add(UserRowData(id: ctr, user: element.user));
  });
  return listUserRowData;
}

class LoadingDataTable extends StatelessWidget {
  const LoadingDataTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder.all(
        color: ThemeManager.primaryAccent,
        borderRadius: BorderRadius.circular(10),
        width: 3,
      ),
      columnSpacing: 30,
      columns: const [
        DataColumn(label: Text("#")),
        DataColumn(label: Text("Name")),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Description")),
      ],
      rows: [
        DataRow(cells: [
          DataCell(SizedBox.shrink()),
          DataCell(SizedBox.shrink()),
          DataCell(Column(
            children: const [
              CircularProgressIndicator(),
            ],
          )),
          DataCell(SizedBox.shrink()),
        ]),
      ],
    );
  }
}
