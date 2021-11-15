import 'package:canteenapp_admin/components/menu_item_card.dart';
import 'package:canteenapp_admin/controllers/cart_controller.dart';
import 'package:canteenapp_admin/screens/activeorder_screen.dart';
import 'package:canteenapp_admin/screens/readyorder_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[Menu(), ActiveOrder(), ReadyOrder()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 245, 242, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
            backgroundColor: Colors.red,
          ),  
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'active order',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Ready order',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Center(
            child: Text(
              "Canteen",
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                color: Color.fromRGBO(62, 68, 98, 1),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
