import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:qr/Components/Themes.dart';

int bottomIndex = 0;

class BottomBar extends StatefulWidget {
  List<GButton> items;
  final VoidCallback? update;
  BottomBar({super.key, required this.items, required this.update});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
      tabs: widget.items,
      selectedIndex: bottomIndex,
      onTabChange: (i) {
        setState(() {
          bottomIndex = i;
          widget.update?.call();
        });
      },
      gap: 10,
      //iconSize: 25,
      color: Themes.light,
      activeColor: Themes.mainColor,
      backgroundColor: Themes.secondaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      curve: Curves.easeInCubic,
      //duration: const Duration(milliseconds: 500),
      //tabActiveBorder: Border.all(color: Colors.black, width: 1),
      //tabBackgroundColor: Themes.secondarySwatch[100]!,
    );
  }
}