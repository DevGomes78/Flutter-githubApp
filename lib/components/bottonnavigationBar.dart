import 'package:flutter/material.dart';
buildBottomNavigationBar() {
  return BottomNavigationBar(

    currentIndex: 2,
    onTap: (index) {
    },
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.black,
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