import 'package:aplikasi_ujikom_admin/auth_method.dart';
import 'package:aplikasi_ujikom_admin/screens/edit_profil_akun.dart';
import 'package:aplikasi_ujikom_admin/global_methods.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/firebase_const.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({super.key});

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TopDrawer(),
        SizedBox(
          height: 30,
        ),
        EditButton(),
        
        SizedBox(
          height: 20,
        ),
        KeluarButton(),
      ],
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfilScreen(
                        uid: FirebaseAuth.instance.currentUser!.uid)));
          },
          child: Row(
            children: [
              Icon(
                IconlyBold.edit,
                color: Colors.purple,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Edit Profile",
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ),
      ),
    );
  }
}

class KeluarButton extends StatelessWidget {
  const KeluarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: InkWell(
          onTap: () {
            GlobalMethods.warningDialog(
              context: context,
              subtitle: "Yakin untuk keluar dari akun?",
              title: "Keluar akun",
              fct: ()async {
                await authInstance.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreens(),
                              ),
                            );
               
               
              },
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.purple,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Keluar",
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ),
      ),
    );
  }
}

class TopDrawer extends StatefulWidget {
  const TopDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<TopDrawer> createState() => _TopDrawerState();
}

class _TopDrawerState extends State<TopDrawer> {
  String? _photoUrl;

  String? _fullName;
  String? _userName;
  String? _email;
  bool _isLoading = false;

  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('akun')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (userDoc == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        _photoUrl = userDoc.get('photoUrl');
        _fullName = userDoc.get('name');
        _email = userDoc.get('email');
        _userName = userDoc.get('username');
        
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: Colors.purple,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            _photoUrl == null?
             Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/empty-profil.png'),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ):
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage( _photoUrl!),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(_fullName == null ? "-" : _fullName!,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: 5,
              ),
              Text(_email == null ? "-" : _email!,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ),
      ),
    );
  }
}
