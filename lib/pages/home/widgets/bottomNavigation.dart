import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:moneyapp/pages/home/homepage.dart';

class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homepage.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.white,
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              Homepage.selectedIndexNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.home_1_outline),
                  label: "Home",
                  activeIcon: Icon(Iconsax.home_1_bold)),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.moneys_outline),
                  label: "Expenses",
                  activeIcon: Icon(Iconsax.moneys_bold)),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.wallet_2_outline),
                  label: "Income",
                  activeIcon: Icon(Iconsax.wallet_2_bold))
            ]);
      },
    );
  }
}
