import 'package:flutter/material.dart';
Widget NameAvatar(String name) {
  return Container(
    height: 50,
    width: 50,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(3.0),
    decoration: boxDecorationAvatar(),
    child: Text(
      getInitials(name.toUpperCase()),
      style: avatarTextStyle,
    ),
  );
}
BoxDecoration boxDecorationAvatar() {
  return BoxDecoration(
    border: Border.all(width: 2, color: Colors.black87),
    borderRadius: BorderRadius.circular(10.0),
  );
}
String getInitials(String text) => text.isNotEmpty
    ? text.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';

TextStyle avatarTextStyle = const TextStyle(
  color: Colors.black87,
  fontSize: 18,
  fontWeight: FontWeight.w500,
);