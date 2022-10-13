import 'package:flutter/material.dart';

import '../constants/string_constants.dart';
buildBottomNavigationBar() {
  return BottomNavigationBar(
    currentIndex: 0,
    fixedColor: Colors.blueAccent,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: (StringConstants.home),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications_none),
        label: (StringConstants.notifications),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: (StringConstants.profile),
      ),
    ],
  );
}