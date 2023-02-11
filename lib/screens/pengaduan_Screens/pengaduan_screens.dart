import 'package:aplikasi_ujikom_admin/model/user_model.dart';
import 'package:aplikasi_ujikom_admin/screens/pengaduan_Screens/pengaduan_screens_petugas.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PengaduanScreens extends StatefulWidget {
  const PengaduanScreens({super.key});

  @override
  State<PengaduanScreens> createState() => _PengaduanScreensState();
}

class _PengaduanScreensState extends State<PengaduanScreens> {
  Future<Widget> chatPage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromSnap(userData);
      return  PengaduanScreensPetugas();
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
