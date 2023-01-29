import 'package:c_masteruser/controllers/user_controller.dart';
import 'package:c_masteruser/models/user.dart';
import 'package:c_masteruser/pages/homepage.dart';
import 'package:c_masteruser/pages/registerpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ThemeManager _themeManager = ThemeManager.getThemeManager();

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  bool passwordVisible = false;
  bool loadLogin = false;
  String? _passwordError;
}

final formKey = GlobalKey<FormBuilderState>();
final emailController = TextEditingController();
final passwordController = TextEditingController();
UserController userController = UserController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            UpperShape(),
            Flexible(
              flex: 12,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                //BEGIN FORM
                child: FormBuilder(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: txtTheme.headline3
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Please Sign In to Continue",
                          style: txtTheme.bodySmall?.copyWith(
                            color: ThemeManager.greyColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        vSpace(30),
                        InputEmail(context, txtTheme),
                        vSpace(20),
                        InputPassword(context, txtTheme),
                        vSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GradientButton(
                              callback: () async {
                                if (widget.loadLogin) {
                                  return;
                                }
                                setState(() {
                                  widget.loadLogin = !widget.loadLogin;
                                });

                                User? userLogin = await login();

                                setState(() {
                                  widget.loadLogin = !widget.loadLogin;
                                });

                                if (userLogin == null) {
                                  // INVALID ACCOUNT

                                  // formKey.currentState?.fields["password"]
                                  //     ?.reset();
                                  setState(() {
                                    formKey.currentState?.fields["password"]
                                        ?.setValue("");
                                    formKey.currentState?.fields["password"]
                                        ?.reset();
                                    widget._passwordError =
                                        "Invalid account / password";
                                  });
                                } else {
                                  // TO LOGIN
                                  Route homeRoute = MaterialPageRoute(
                                      builder: ((context) =>
                                          HomePage(user: userLogin)));
                                  Navigator.of(context)
                                      .pushReplacement(homeRoute);
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
                                  if (widget.loadLogin) ...[
                                    CircularProgressIndicator(
                                      color: ThemeManager.darkPrimaryColor,
                                      strokeWidth: 5,
                                    ),
                                  ] else ...[
                                    Text(
                                      "Login",
                                      style: txtTheme.headlineSmall?.copyWith(
                                        color: ThemeManager.whiteColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_rounded,
                                      size: 30,
                                      color: ThemeManager.whiteColor,
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Route registerRoute = MaterialPageRoute(
                                    builder: ((context) => RegisterPage()));
                                Navigator.of(context)
                                    .pushReplacement(registerRoute);
                              },
                              child: Text(
                                "Register Now!",
                                style: TextStyle(color: Colors.blue[800]),
                              ),
                            ),
                          ],
                        ),
                        vSpace(30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<User?> login() async {
    if (formKey.currentState!.validate()) {
      final String email = formKey.currentState?.fields["email"]?.value;
      final String password = formKey.currentState?.fields["password"]?.value;

      User? userLogin =
          await userController.login(email: email, password: password);
      return userLogin;
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty!";
    }
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
  }

  FormBuilderTextField InputEmail(BuildContext context, TextTheme txtTheme) {
    return FormBuilderTextField(
      name: "email",
      validator: ((value) => (validateEmail(value))),
      cursorColor: ThemeManager.primaryColor,
      decoration: InputDecoration(
        labelText: "Email",
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

  FormBuilderTextField InputPassword(BuildContext context, TextTheme txtTheme) {
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

class DecorationBox extends StatefulWidget {
  const DecorationBox({
    Key? key,
    required this.width,
    required this.height,
    required this.rotation,
    required this.stopGradient,
    required this.borderRadius,
    required this.colorGradient,
  }) : super(key: key);

  final double width;
  final double height;
  final double rotation;
  final List<double>? stopGradient;
  final List<Color> colorGradient;
  final double borderRadius;

  @override
  State<DecorationBox> createState() => _DecorationBoxState();
}

class _DecorationBoxState extends State<DecorationBox> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.rotation,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ],
          gradient: LinearGradient(
            colors: widget.colorGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: widget.stopGradient,
          ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius,
          ),
        ),
        height: widget.height,
        width: widget.width,
      ),
    );
  }
}
