import 'package:flutter/material.dart';

Widget iconMessageView({
  required IconData icon,
  required String message,
  double iconSize = 100,
  textColor = Colors.white,
  double? topMargin,
}) {
  return Column(
    mainAxisAlignment:
        topMargin == null ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: [
      SizedBox(height: topMargin),
      Icon(
        icon,
        size: iconSize,
        color: Colors.grey,
      ),
      const SizedBox(height: 16),
      Text(message, style: TextStyle(color: textColor)),
    ],
  );
}
