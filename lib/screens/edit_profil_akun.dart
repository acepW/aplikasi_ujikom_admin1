import 'dart:io';
import 'dart:typed_data';

import 'package:aplikasi_ujikom_admin/btm_bar.dart';
import 'package:aplikasi_ujikom_admin/global_methods.dart';


import 'package:aplikasi_ujikom_admin/storage_method.dart';
import 'package:aplikasi_ujikom_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../const/firebase_const.dart';

class EditProfilScreen extends StatefulWidget {
  final String uid;

  const EditProfilScreen({super.key, required this.uid});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _userNameTextController =
      TextEditingController(text: "");

  final TextEditingController _fullNameController =
      TextEditingController(text: "");

  late File _profileImage;
  Uint8List? _image;
  String? _photoUrl;

  String? _fullName;
  String? _userName;

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
      User currentUser = _auth.currentUser!;
      String _uid = user!.uid;

      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('akun')
          .doc(widget.uid)
          .get();
      if (userDoc == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        _photoUrl = userDoc.get('photoUrl');
        _fullName = userDoc.get('name');
        _fullNameController.text = userDoc.get('name');

        _userName = userDoc.get('username');
        _userNameTextController.text = userDoc.get('username');
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 20,
                  )),
              centerTitle: true,
              title: Text(
                'Edit Profil',
                style: GoogleFonts.rubik(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                                backgroundColor: Colors.red,
                              )
                            : _photoUrl != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(_photoUrl!),
                                  )
                                : CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        'https://i.stack.imgur.com/l60Hf.png'),
                                  ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () async {
                              try {
                                Uint8List file =
                                    await pickImage(ImageSource.gallery);
                                if (file != null) {
                                  setState(() {
                                    _image = file;
                                  });
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: const ShapeDecoration(
                                  color: Colors.purple, shape: CircleBorder()),
                              child: const Icon(
                                Icons.camera,
                                size: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Container(
                        width: 341,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Lengkap',
                              style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              maxLength: 20,
                              controller: _fullNameController,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                hintText: 'Masukan Nama',
                                hintStyle: GoogleFonts.rubik(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.purple),
                                ),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: 341,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User name',
                              style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              maxLength: 20,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'(anjing|babi|monyet|)',
                                        caseSensitive: false),
                                    replacementString: '******')
                              ],
                              controller: _userNameTextController,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.5, color: Colors.purple),
                                ),
                                hintText: 'Masukan Nama',
                                hintStyle: GoogleFonts.rubik(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 45,
                    ),
                    _isLoading
                        ? CircularProgressIndicator(
                            color: Colors.purple,
                          )
                        : InkWell(
                            onTap: () async {
                              String _uid = user!.uid;
                              String? photoUrl;

                              if (_image == null) {
                                photoUrl = _photoUrl;
                                
                                
                              } else {
                                photoUrl = await StorageMethods()
                                    .uploadImageToStorage(
                                        'profilePics', _image!, false);
                              }
                              try {
                                await FirebaseFirestore.instance
                                    .collection('akun')
                                    .doc(widget.uid)
                                    .update({
                                  'username': _userNameTextController.text,
                                  'name': _fullNameController.text,
                                  'photoUrl': photoUrl
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomBarScreen()));
                                setState(() {
                                  _userName = _userNameTextController.text;

                                  _fullName = _fullNameController.text;
                                  _photoUrl = photoUrl;
                                  showSnackBar(
                                    context,
                                    'Akun telah diperbarui!',
                                  );
                                });
                              } catch (err) {
                                GlobalMethods.errorDialog(
                                    subtitle: err.toString(), context: context);
                              }
                            },
                            child: Container(
                              width: 342,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  'Simpan',
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            ),
          );
  }
}
