import 'package:aplikasi_ujikom_admin/auth_method.dart';
import 'package:aplikasi_ujikom_admin/provider/user_provider.dart';

import 'package:aplikasi_ujikom_admin/screens/drawer.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).refreshUser();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            children: [DrawerHome()],
          )),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Aplikasi Ujikom",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500))),
         
        ),
       
      ),
    );
  }
}
