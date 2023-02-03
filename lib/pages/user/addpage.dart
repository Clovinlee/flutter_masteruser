// ignore_for_file: file_names, must_be_immutable, use_build_context_synchronously

import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:c_masteruser/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class AddUserPage extends StatefulWidget {
  AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();

  bool passwordVisible = false;
  String? _passwordError;
  bool isLoading = false;
}

final formKey = GlobalKey<FormBuilderState>();
UserController userController = UserController();
FToast fToast = FToast();

class _AddUserPageState extends State<AddUserPage> {
  @override
  void initState() {
    fToast.init(context);
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
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: "Return back to master page",
          );
        })),
        title: Text(
          "Add New User",
          style: txtTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: ThemeManager.darkSecondaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add New User",
                style:
                    txtTheme.headline3?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Please fill out the user details",
                style: txtTheme.bodySmall?.copyWith(
                  color: ThemeManager.greyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              vSpace(20),
              FormBuilder(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    formInput(context, txtTheme, validateEmail, "email",
                        "Email", Icons.email_rounded),
                    vSpace(20),
                    formInput(
                        context,
                        txtTheme,
                        (val) => val == null || val.isEmpty
                            ? "Name cannot be empty!"
                            : null,
                        "name",
                        "Name",
                        Icons.person),
                    vSpace(20),
                    formInput(context, txtTheme, null, "description",
                        "Description", null,
                        maxLineInput: 4,
                        labelBehavior: FloatingLabelBehavior.always),
                    vSpace(20),
                    formPassword(context, txtTheme),
                    vSpace(20),
                    GradientButton(
                      gradient: Gradients.buildGradient(
                          Alignment.centerLeft,
                          Alignment.centerRight,
                          [Colors.green.shade400, Colors.green.shade500]),
                      callback: () async {
                        if (widget.isLoading) {
                          return;
                        }

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            widget.isLoading = true;
                          });
                          UserModel? umodel = await addUser();

                          setState(() {
                            widget.isLoading = false;
                          });

                          if (umodel == null) {
                            errorToast(txtTheme,
                                "Add User Error, please contact admin!");
                          } else {
                            List<User>? userReturn = umodel.data;
                            if (userReturn == null) {
                              errorToast(txtTheme, umodel.message.toString());

                              // ignore: avoid_print
                              print(umodel.message);
                            } else {
                              User u = userReturn.first;
                              successToast(
                                  txtTheme, "User ${u.name} has been aded");
                              // GO BACK TO PREVIOUS PAGE
                              Navigator.pop(context, {"success": true});
                            }
                          }
                        }
                      },
                      increaseWidthBy: double.infinity,
                      increaseHeightBy: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.isLoading == true
                            ? [
                                CircularProgressIndicator(
                                  color: ThemeManager.whiteColor,
                                )
                              ]
                            : [
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
              )
            ],
          ),
        ),
      ),
    );
  }

  FormBuilderTextField formPassword(BuildContext context, TextTheme txtTheme) {
    return FormBuilderTextField(
      name: "password",
      validator: ((value) => (validatePassword(value))),
      cursorColor: ThemeManager.primaryColor,
      obscureText: !widget.passwordVisible,
      obscuringCharacter: "*",
      onChanged: ((value) {
        if (widget._passwordError != null) {
          setState(() {
            widget._passwordError = null;
          });
        }
      }),
      decoration: InputDecoration(
        labelText: "Password",
        errorText: widget._passwordError,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.lock_rounded,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                widget.passwordVisible = !widget.passwordVisible;
              });
            },
            icon: Icon(
              widget.passwordVisible
                  ? Icons.disabled_visible_rounded
                  : Icons.visibility_rounded,
              color: Colors.grey,
            )),
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.error)
              ? Theme.of(context).colorScheme.error
              : Color.fromARGB(255, 90, 90, 85);
          return txtTheme.bodyMedium!.copyWith(
            color: color,
          );
        }),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Color.fromARGB(255, 197, 191, 191).withOpacity(0.35),
      ),
    );
  }
}

Future<UserModel?> addUser() async {
  final String email = formKey.currentState?.fields["email"]?.value;
  final String name = formKey.currentState?.fields["name"]?.value;
  final String description =
      formKey.currentState?.fields["description"]?.value ?? "";
  final String password = formKey.currentState?.fields["password"]?.value;
  const int type = 1;
  UserModel? umodel;
  umodel = await userController.addUser(email, name, description, password,
      type: type);
  // Returned user model instead of user because user model might return message of existing email warning.
  return umodel;
}

FormBuilderTextField formInput(
    BuildContext context,
    TextTheme txtTheme,
    String? Function(String?)? validator,
    String name,
    String labelText,
    IconData? icon,
    {int maxLineInput = 1,
    FloatingLabelBehavior labelBehavior = FloatingLabelBehavior.auto}) {
  return FormBuilderTextField(
    name: name,
    validator: validator,
    cursorColor: ThemeManager.primaryColor,
    decoration: InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: labelBehavior,
      prefixIcon: Icon(
        icon,
        color: Colors.grey,
      ),
      floatingLabelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final Color color = states.contains(MaterialState.error)
            ? Theme.of(context).colorScheme.error
            : Color.fromARGB(255, 90, 90, 85);
        return txtTheme.bodyMedium!.copyWith(
          color: color,
        );
      }),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide.none,
      ),
      fillColor: Color.fromARGB(255, 197, 191, 191).withOpacity(0.35),
    ),
    maxLines: maxLineInput,
  );
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password cannot be empty!";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email cannot be empty!";
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Invalid Email address format!";
  }
  return null;
}
