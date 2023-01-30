import 'package:c_masteruser/models/user.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({required this.user, super.key});

  final User user;

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
