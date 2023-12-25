import 'package:course_online/screens/desktop/desktopmain.dart';
import 'package:course_online/screens/mobile/mobile.main.dart';
import 'package:flutter/material.dart';

class MainScreenAdmin extends StatelessWidget {
  const MainScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaku = MediaQuery.of(context).size.width;
    return mediaku < 600 ? const MobileMain() : const DesktopMain();
  }
}
