import 'dart:ui';

import 'package:flutter/material.dart';

// Replace these with your actual constants
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color transparentColor = Colors.transparent;
const double fontSize20 = 20.0;
const FontWeight fontWeightSemiBold = FontWeight.w600;

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> titles = ['Home', 'Search', 'Add', 'Messages', 'Profile'];
  final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.add_circle_outline,
    Icons.message,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero)
                      .animate(animation),
              child: child,
            ),
          );
        },
        key: ValueKey<int>(_selectedIndex),
        child: page(titles[_selectedIndex]),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: transparentColor,
          splashColor: transparentColor,
          hoverColor: transparentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            type: BottomNavigationBarType.fixed,
            backgroundColor: transparentColor,
            currentIndex: _selectedIndex,
            onTap: _onTap,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            elevation: 0,
            items: List.generate(5, (index) {
              return BottomNavigationBarItem(
                icon: _getIcon(icons[index], index),
                label: '',
              );
            }),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Bottom navigation bar icon builder
  Widget _getIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    Widget iconContent = Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? whiteColor : transparentColor,
          width: 4,
        ),
        color:
            isSelected ? Colors.red.withValues(alpha: 0.4) : transparentColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 30, color: whiteColor),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.translationValues(0, isSelected ? -25 : 0, 0),
      curve: Curves.easeOut,
      child: isSelected
          ? ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: iconContent,
              ),
            )
          : iconContent,
    );
  }

  Widget page(String title) {
    return Container(
      key: ValueKey(title),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: blackColor,
            fontSize: fontSize20,
            fontWeight: fontWeightSemiBold,
          ),
        ),
      ),
    );
  }
}
