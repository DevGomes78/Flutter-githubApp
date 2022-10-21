import 'package:flutter/material.dart';
buildBottomNavigationBar() {
  return BottomNavigationBar(
    mouseCursor: SystemMouseCursors.grab,
    currentIndex:2,
    onTap: (index) {
    },
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: ('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: ('Notificaçoes'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: ('Perfil'),
      ),
    ],

  );
}