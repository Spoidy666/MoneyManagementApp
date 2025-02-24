import 'package:flutter/material.dart';
import 'package:moneyapp/pages/home/homepage.dart';

class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homepage.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[700],
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              Homepage.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_rupee_rounded), label: "Expenses"),
              BottomNavigationBarItem(icon: Icon(Icons.money), label: "Income")
            ]);
      },
    );
  }
}
