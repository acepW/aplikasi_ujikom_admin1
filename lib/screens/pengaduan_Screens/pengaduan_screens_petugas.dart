import 'package:aplikasi_ujikom_admin/screens/drawer.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_aduan_petugas_ditolak.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diproses.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/list_pengaduan_petugas_diverivikasi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PengaduanScreensPetugas extends StatefulWidget {
  const PengaduanScreensPetugas({super.key});

  @override
  State<PengaduanScreensPetugas> createState() =>
      _PengaduanScreensPetugasState();
}

class _PengaduanScreensPetugasState extends State<PengaduanScreensPetugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            children: [DrawerHome()],
          )),
        ),
        appBar: AppBar(
           backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Pengaduan",
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
                          builder: (context) => ListPengaduanPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      "Semua Aduan",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20)),
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
                          builder: (context) => ListPengaduanDiperiksaPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      "Aduan Belum Di Proses",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20)),
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
                              ListPengaduanVerifikasiPetugas()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      "Aduan Sudah Di Verifikasi",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20)),
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
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      "Aduan Di Tolak",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
