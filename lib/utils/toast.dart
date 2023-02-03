import 'package:c_masteruser/pages/user/addpage.dart';
import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:c_masteruser/utils/sizedbox_spacer.dart';
import 'package:flutter/material.dart';

successToast(TextTheme txtTheme, String msg) {
  showToast(
    msg,
    txtTheme.bodySmall!.copyWith(color: ThemeManager.whiteColor),
    icon: Icons.check_circle_rounded,
    bgColor: Colors.green.shade400,
  );
}

errorToast(TextTheme txtTheme, String msg) {
  showToast(
    msg,
    txtTheme.bodySmall!.copyWith(color: ThemeManager.whiteColor),
    icon: Icons.dangerous_rounded,
    bgColor: Colors.red.shade400,
  );
}

showToast(
  String msg,
  TextStyle txtStyle, {
  Color bgColor = ThemeManager.greyColor,
  Color fgColor = ThemeManager.whiteColor,
  IconData? icon = Icons.check,
}) {
  Widget toast = Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: fgColor,
            size: 30,
          ),
          hSpace(10),
          Expanded(
            child: Text(
              msg,
              style: txtStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ));
  fToast.showToast(child: toast);
}
