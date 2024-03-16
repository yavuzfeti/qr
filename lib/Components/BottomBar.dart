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
    return Container(
      color: Colors.black,
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: Themes.light,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(35, 10, 35, 25),
        child: GNav(
          tabs: widget.items,
          selectedIndex: bottomIndex,
          onTabChange: (i) {
            setState(() {
              bottomIndex = i;
              widget.update?.call();
            });
          },
          gap: 8,
          iconSize: 35,
          color: Themes.grey,
          tabBackgroundColor: Themes.lightGrey,
          activeColor: Themes.dark,
          backgroundColor: Themes.light,
          tabBorderRadius: 15,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          curve: Curves.easeInExpo,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}