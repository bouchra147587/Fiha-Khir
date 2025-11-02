import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'custom_bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fiha Khir App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text("Home Screen")),
    const Center(child: Text("Problems Screen")),
    const Center(child: Text("Orgs Screen")),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      
          bottomNavigationBar: CustomBottomNav(
  selectedIndex: _selectedIndex,
  onItemTapped: _onItemTapped,
),

    );
  }
}
