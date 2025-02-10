import 'package:bitcoin_map/presentation/screen/around_you_screen.dart';
import 'package:bitcoin_map/presentation/screen/communities_screen.dart';
import 'package:bitcoin_map/presentation/screen/shops_list_screen.dart';
import 'package:flutter/material.dart';

import '../../telegram_mini_app/telegram_mini_app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [AroundYouScreen(), ShopsListScreen(), CommunitiesScreen()],
        ),
      ),
      bottomNavigationBar: SizedBox(
          height: isSupported ? 56 : 42,
          child: SafeArea(
            top: false,
            right: false,
            left: false,
            bottom: isSupported,
            child: BottomNavigationBar(
              unselectedFontSize: 0.0,
              selectedFontSize: 0.0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.pin_drop), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.business_outlined), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.people_alt), label: ''),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          )),
    );
  }
}
