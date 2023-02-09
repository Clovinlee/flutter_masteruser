import 'package:c_masteruser/api/api_client.dart';
import 'package:c_masteruser/api_retrofit/api_service.dart';
import 'package:c_masteruser/api_retrofit/user_response.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.user, super.key});

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();

  String txtData = "User Data";
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              UserResponse userResponse = await getData(widget.user);
              setState(() {
                widget.txtData = userResponse.data!.first.name.toString();
              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Get User Data with Retrofit",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          vSpace(20),
          Text(
            widget.txtData,
            style: TextStyle(fontSize: 20),
          )
        ],
      ),
    );
  }
}

getData(User usr) async {
  ApiService apiService = ApiService(ApiClient.getDioClient());

  UserResponse userResponse = await apiService.getUserData(usr.id.toString());
  return userResponse;
}
