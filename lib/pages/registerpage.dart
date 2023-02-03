import 'dart:math';

import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/homepage.dart';
import 'package:c_masteruser/pages/loginpage.dart';
import 'package:c_masteruser/pages/wrapperpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/page_change.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

import '../utils/sizedbox_spacer.dart';


final formKey = GlobalKey<FormBuilderState>();

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

  bool passwordVisible = false;
  String? _passwordError;
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            UpperShape(),
            Flexible(
              flex: 12,
              child: SizedBox(
                width: double.infinity, //sama kyk match parent
                height: double.infinity,
                child: FormBuilder(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: txtTheme.headline3
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome Sensei!",
                          style: txtTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          )
                        ),
                        vSpace(20),
                        inputNama(context, txtTheme),
                        vSpace(15),
                        inputEmail(context, txtTheme),
                        vSpace(15),
                        inputTelp(context, txtTheme),
                        vSpace(15),
                        inputPassword(context, txtTheme),
                        vSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GradientButton(
                              callback: () async {
                                User? userLogin = await register();
                                if (userLogin == null) {
                                  var sb = SnackBar(content: Text("Gagal"));
                                  ScaffoldMessenger.of(context).showSnackBar(sb);
                                }
                              },
                              gradient: Gradients.buildGradient(
                                  Alignment.centerLeft, Alignment.centerRight, [
                                ThemeManager.secondaryColor,
                                ThemeManager.primaryColor,
                              ]),
                              increaseHeightBy: 20,
                              increaseWidthBy: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ...[
                                    Text(
                                      "Register",
                                      style: txtTheme.headlineSmall?.copyWith(
                                        color: ThemeManager.whiteColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.door_sliding,
                                      size: 30,
                                      color: ThemeManager.whiteColor,
                                    ),
                                  // ]
                                ],
                              ),
                            )
                          ],
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Route loginRoute =
                        //         MaterialPageRoute(builder: ((context) => LoginPage()));
                        //     Navigator.of(context).pushReplacement(loginRoute);
                        //   },
                        //   child: Text("Go To Login! (THIS REPLACE ROUTE)")
                        // ),
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                switchPage(context, LoginPage());
                              },
                              child: Text(
                                "Log me in!",
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                            ),
                          ],
                        ),
                        vSpace(30),
                      ],
                    )
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty!";
    }
    return null;
  }

  String? validateName(String? value){
    if (value == null || value.isEmpty) {
      return "Name cannot be empty!";
    }
    return null;
  }

  String? validateTelp(String? value){
    if (value == null || value.isEmpty) {
      return "Name cannot be empty!";
    }
    if (value.length < 12) {
      return "Must be 12 digit!";
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

  Future<User?> register() async {
    if (formKey.currentState!.validate()) {
      final String email = formKey.currentState?.fields["email"]?.value;
      final String nama = formKey.currentState?.fields["nama"]?.value;
      final String telp = formKey.currentState?.fields["telp"]?.value;
      final String password = formKey.currentState?.fields["password"]?.value;

      User? userLogin =
          await userController.register(email: email, password: password, nama: nama, telp: telp);
      return userLogin;
    }
    return null;
  }

  FormBuilderTextField inputNama(BuildContext context, TextTheme txtTheme){
    return FormBuilderTextField(
      name: "nama",
      validator: ((value) => (validateName(value))),
      cursorColor: ThemeManager.primaryColor,
      decoration: InputDecoration(
        labelText: "Nama sensei",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.account_box_outlined,
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
    );
  }

  FormBuilderTextField inputEmail(BuildContext context, TextTheme txtTheme) {
    return FormBuilderTextField(
      name: "email",
      validator: ((value) => (validateEmail(value))),
      cursorColor: ThemeManager.primaryColor,
      decoration: InputDecoration(
        labelText: "Email sensei",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.email_rounded,
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
    );
  }

  FormBuilderTextField inputPassword(BuildContext context, TextTheme txtTheme) {
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
        labelText: "Password sensei",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.lock,
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
          )
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
    );
  }

  FormBuilderTextField inputTelp(BuildContext context, TextTheme txtTheme) {
    return FormBuilderTextField(
      name:"telp",
      validator: ((value) => (validateTelp(value))),
      keyboardType: TextInputType.phone,
      cursorColor: ThemeManager.primaryColor,
      decoration: InputDecoration(
        labelText: "Phone number",
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: Icon(
          Icons.call,
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
    );
  }
}

class UpperShape extends StatefulWidget {
  const UpperShape({
    Key? key,
  }) : super(key: key);

  @override
  State<UpperShape> createState() => _UpperShapeState();
}

class _UpperShapeState extends State<UpperShape> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 5,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: const [
              Positioned(
                  right: -50,
                  top: -20,
                  child: DecorationBox(
                    width: 200,
                    height: 150,
                    rotation: -pi / 5,
                    stopGradient: [0.1, 0.6],
                    borderRadius: 20,
                    colorGradient: [
                      ThemeManager.secondaryColor,
                      ThemeManager.primaryColor
                    ],
                  )),
              Positioned(
                right: -50,
                top: 20,
                child: DecorationBox(
                  width: 150,
                  height: 150,
                  rotation: -pi / 7,
                  stopGradient: [0.1, 0.6],
                  borderRadius: 20,
                  colorGradient: [
                    ThemeManager.primaryColor,
                    ThemeManager.secondaryColor
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
