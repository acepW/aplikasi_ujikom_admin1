import 'package:aplikasi_ujikom_admin/akun_not_akses.dart';

import 'package:aplikasi_ujikom_admin/model/user_model.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_screens.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidasiScreens extends StatefulWidget {
  const ValidasiScreens({super.key});

  @override
  State<ValidasiScreens> createState() => _ValidasiScreensState();
}

class _ValidasiScreensState extends State<ValidasiScreens> {
  Future<Widget> chatPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('akun')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromSnap(userData);
      return userModel.role == "admin"
          ? PengaduanScreens()
          : AkunNotAkses();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: chatPage(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        });
  }
}