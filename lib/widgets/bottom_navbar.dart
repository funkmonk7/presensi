import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/jadwal_page.dart';
import '../pages/presensi_page.dart';
import '../pages/akun_page.dart';

class BottomNavBar extends StatefulWidget {
  final String userName;
  final String userNpm;

  const BottomNavBar({
    super.key,
    required this.userName,
    required this.userNpm,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Daftar halaman, data user dikirim ke AkunPage
    _pages = [
      const HomePage(),
      const JadwalPage(),
      const PresensiPage(),
      AkunPage(
        userName: widget.userName,
        userNpm: widget.userNpm,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Presensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
