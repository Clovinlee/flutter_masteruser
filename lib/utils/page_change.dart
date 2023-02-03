import 'package:flutter/material.dart';

void switchPage(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

_defaultFunction(dynamic) {
  return null;
}

void stackNextPage(BuildContext context, Widget page,
    {Function(dynamic) callback = _defaultFunction}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page))
      .then(callback);
}
