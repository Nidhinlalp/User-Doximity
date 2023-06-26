import 'package:doximity/view/Appoinment/appointment_page.dart';
import 'package:doximity/view/chat/chat.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/favorite/favorite.dart';
import 'package:doximity/view/home/home_screen.dart';
import 'package:doximity/view_model/home/home_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _pages = [
    const LogedInWidget(),
    const AppointMentPage(),
    FavoritePage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BotomNav>(
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: _pages[value.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: value.onTap,
            selectedItemColor: kBlackColor800,
            unselectedItemColor: kGrayColor900,
            showSelectedLabels: true,
            currentIndex: value.currentIndex,
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                tooltip: 'Home',
                icon: Icon(IconlyLight.home),
              ),
              BottomNavigationBarItem(
                label: 'Appoinment',
                tooltip: 'Appoinment',
                icon: Icon(IconlyLight.calendar),
              ),
              BottomNavigationBarItem(
                label: 'Favorite',
                tooltip: 'Favorite',
                icon: Icon(IconlyLight.bookmark),
              ),
              BottomNavigationBarItem(
                label: 'Chat',
                tooltip: 'Chat',
                icon: Icon(IconlyLight.chat),
              )
            ],
          ),
        );
      },
    );
  }
}
