import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_petugas/widget/detail_aduan_petugas.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPengaduanDiperiksaPetugas extends StatefulWidget {
  const ListPengaduanDiperiksaPetugas({super.key});

  @override
  State<ListPengaduanDiperiksaPetugas> createState() =>
      _ListPengaduanDiperiksaPetugasState();
}

class _ListPengaduanDiperiksaPetugasState
    extends State<ListPengaduanDiperiksaPetugas> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Pengaduan Belum Di Proses",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500))),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('aduan')
                  .where('status', isEqualTo: 'di periksa')
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length < 1) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text("Belum Ada Aduanmu",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      ),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        String judul = snapshot.data.docs[index]['judul'];
                        String deskripsi =
                            snapshot.data.docs[index]['deskripsi'];
                        var time =
                            snapshot.data.docs[index]['createdAt'].toDate();
                        String imageUrl = snapshot.data.docs[index]['imageUrl'];
                        String name = snapshot.data.docs[index]['name'];
                        String pengaduId =
                            snapshot.data.docs[index]['pengaduId'];
                        String photoUrl = snapshot.data.docs[index]['photoUrl'];
                        String postId = snapshot.data.docs[index]['postId'];
                        String status = snapshot.data.docs[index]['status'];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailAduanPetugas(
                                        judul: judul,
                                        deskripsi: deskripsi,
                                        postId: postId,
                                        status: status,
                                        imageUrl: imageUrl,
                                        name: name,
                                        tanggal: time)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(judul,
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500))),
                                    Flexible(
                                      child: Text(deskripsi,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.w500))),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              },
            )),
      ),
    );
  }
}
