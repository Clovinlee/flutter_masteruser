import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              ThemeManager.primaryColor,
              ThemeManager.secondaryColor,
            ],
            stops: const [0.6, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: DecorationBox(
                width: double.infinity,
                height: double.infinity / 2,
                rotation: -pi / 3,
                stopGradient: const [0.1, 1],
                borderRadius: 20,
                colorGradient: const [
                  ThemeManager.whiteColor,
                  ThemeManager.whiteColor,
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoShape(),
                  vSpace(50),
                  Text(
                    "MasterUser",
                    style: txtTheme.displayMedium?.copyWith(
                        color: ThemeManager.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  vSpace(20),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      color: ThemeManager.primaryColor,
                      strokeWidth: 8,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LogoShape extends StatelessWidget {
  const LogoShape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          Positioned(
            top: 20,
            child: DecorationBox(
              width: 150,
              height: 150,
              rotation: -pi / 5,
              stopGradient: [0.1, 0.6],
              borderRadius: 20,
              colorGradient: [
                ThemeManager.secondaryColor,
                ThemeManager.primaryColor,
              ],
            ),
          ),
          Positioned(
            top: -20,
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
    );
  }
}

class DecorationBox extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
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
            colors: colorGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: stopGradient,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
