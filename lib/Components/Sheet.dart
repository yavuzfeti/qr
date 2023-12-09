import 'package:flutter/material.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/main.dart';

class Sheet
{
  static show(String mesaj,{IconData? icon}) async
  {
    showModalBottomSheet(
      context: navKey.currentState!.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext bottomContext, StateSetter updateView) =>
            DraggableScrollableSheet(
                initialChildSize: 0.9,
                maxChildSize: 1,
                expand: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Themes.back,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      height: MediaQuery.sizeOf(context).height,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: []
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}