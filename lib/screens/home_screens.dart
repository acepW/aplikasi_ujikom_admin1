import 'package:aplikasi_ujikom_admin/auth_method.dart';
import 'package:aplikasi_ujikom_admin/provider/user_provider.dart';
import 'package:aplikasi_ujikom_admin/screens/daftar_petugas.dart';

import 'package:aplikasi_ujikom_admin/screens/drawer.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_aduan_admin_ditolak.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_admin.dart';

import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diproses.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diverivikasi.dart';
import 'package:aplikasi_ujikom_admin/screens/registrasi_petugas.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListPengaduanAdmin()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Semua",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Aduan User",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListPengaduanDiperiksaAdmin()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.purple,
                    
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Proses",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListPengaduanVerifikasiAdmin()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Verefikasi",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
               
               Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListPengaduanDiTolakPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aduan",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Di Tolak",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RegistrasiPetugasScreens()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Registrasi",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Petugas",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DaftarPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.pink,
                   
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 50),
                    child: Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Daftar",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "Semua Petugas",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
