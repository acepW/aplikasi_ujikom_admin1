import 'package:aplikasi_ujikom_admin/auth_method.dart';
import 'package:aplikasi_ujikom_admin/provider/user_provider.dart';
import 'package:aplikasi_ujikom_admin/screens/daftar_petugas.dart';

import 'package:aplikasi_ujikom_admin/screens/drawer.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_admin/list_aduan_admin_ditolak.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_admin/list_pengaduan_admin.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_admin/list_pengaduan_petugas_diproses.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_admin/list_pengaduan_petugas_diverivikasi.dart';


import 'package:aplikasi_ujikom_admin/screens/registrasi_petugas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PengaduanScreens extends StatefulWidget {
  const PengaduanScreens({super.key});

  @override
  State<PengaduanScreens> createState() => _PengaduanScreensState();
}

class _PengaduanScreensState extends State<PengaduanScreens> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).refreshUser();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
           width: 200,
          child: DrawerHome(),
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30,),
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
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Semua",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Aduan User",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/all.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
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
                  child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aduan",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Di Proses",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/work-process.png'),
                                  fit: BoxFit.fill)),
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
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aduan",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Di Verefikasi",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/accept.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
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
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Aduan",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Di Tolak",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/rejected.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
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
                child:Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Registrasi",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Petugas",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/register.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30,bottom:10 ),
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
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(2, 6))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Daftar",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                  "Petugas",
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/officer.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ],
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
