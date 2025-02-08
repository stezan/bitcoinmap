import 'package:bitcoin_map/presentation/screen/around_you_screen.dart';
import 'package:bitcoin_map/presentation/screen/shops_list_screen.dart';
import 'package:flutter/material.dart';

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
          children: const [AroundYouScreen(), ShopsListScreen()],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 42, // Set a short height for the bottom navigation bar
        child: BottomNavigationBar(
          unselectedFontSize: 0.0,
          selectedFontSize: 0.0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.pin_drop),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business_outlined),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
