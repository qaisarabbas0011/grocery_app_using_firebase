import 'package:flutter/material.dart';
import 'package:grocery_plus/screens/home_screen.dart';
import 'package:grocery_plus/screens/cart_screen.dart';
import 'package:grocery_plus/screens/favorite_screen.dart';
import 'package:grocery_plus/screens/profile_screen.dart';
import 'package:grocery_plus/constants/colors.dart';  // Assuming AppColors is defined in constants/colors.dart

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;  // Track the selected index for bottom navigation

  // List of screens for each bottom navigation tab
  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex], // Show selected screen

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,  // Set current tab
        onTap: (index) {
          setState(() {
            selectedIndex = index;  // Update selected tab on tap
          });
        },
        type: BottomNavigationBarType.fixed,  // Keep items fixed
        backgroundColor: Colors.white,  // Set background color for bottom nav bar
        selectedItemColor: AppColors.primaryColor,  // Color of selected item
        unselectedItemColor: AppColors.fontColor,  // Color of unselected item
        showSelectedLabels: true,  // Show label for selected item
        showUnselectedLabels: true,  // Show label for unselected item
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              size: 28,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 28,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}