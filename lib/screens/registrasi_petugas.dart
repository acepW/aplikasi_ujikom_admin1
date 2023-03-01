import 'dart:typed_data';

import 'package:aplikasi_ujikom_admin/auth_method.dart';
import 'package:aplikasi_ujikom_admin/btm_bar.dart';

import 'package:aplikasi_ujikom_admin/screens/pengaduan_screens.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:aplikasi_ujikom_admin/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RegistrasiPetugasScreens extends StatefulWidget {
  const RegistrasiPetugasScreens({super.key});

  @override
  State<RegistrasiPetugasScreens> createState() =>
      _RegistrasiPetugasScreensState();
}

class _RegistrasiPetugasScreensState extends State<RegistrasiPetugasScreens> {
  Uint8List? _image;

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();

  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();

  final _fullNameFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  final _userNameFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();

    _emailTextController.dispose();
    _userNameTextController.dispose();
    _passTextController.dispose();

    _fullNameFocusNode.dispose();
    _userNameFocusNode.dispose();
    _passFocusNode.dispose();

    super.dispose();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        createdAt: Timestamp.now(),
        password: _passTextController.text,
        username: _userNameTextController.text,
        email: _emailTextController.text,
        name: _fullNameController.text,
        role: "petugas",
        file: _image);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Lakukan registrasi Petugas disini",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.purple,
                            fontSize: 30,
                            fontWeight: FontWeight.w500))),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  focusNode: _emailFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_fullNameFocusNode),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTextController,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Please enter a valid Email adress";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Email",
                     
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  focusNode: _passFocusNode,
                  textInputAction: TextInputAction.next,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passTextController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_userNameFocusNode),
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.purple,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Password",
                     
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 20,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_passFocusNode),
                  controller: _fullNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid full name";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Nama Lengkap",
                    
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLength: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a valid  user name";
                    } else {
                      return null;
                    }
                  },
                  focusNode: _userNameFocusNode,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_fullNameFocusNode),
                  controller: _userNameTextController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.purple),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Username",
                     
                      hintStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500))),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    signUpUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child:_isLoading?
                      CircularProgressIndicator(color: Colors.white,)
                      : Text(
                        "Registrasi",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      )),
    );
  }
}
