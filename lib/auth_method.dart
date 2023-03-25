import 'package:aplikasi_ujikom_admin/const/firebase_const.dart';
import 'package:aplikasi_ujikom_admin/screens/login_screens.dart';
import 'package:aplikasi_ujikom_admin/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:aplikasi_ujikom_admin/model/user_model.dart' as model;

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final User? user = authInstance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
   Future<model.UserModel> getUserDetails() async {
   

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('akun').doc(user!.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required Timestamp createdAt,
    required String email,
    required String name,
    required String password,
    required String username,
    required String role,
    required Uint8List? file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email != null && email.isNotEmpty) {
        String? profileUrl;
        if (file == null) {
          profileUrl = '';
        } else {
          profileUrl = await StorageMethods()
              .uploadImageToStorage('profilePics', file, false);
        }
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.UserModel _user = model.UserModel(
            createdAt: Timestamp.now(),
            name: name,
            username: username,
            uid: cred.user!.uid,
            photoUrl: profileUrl,
            email: email,
            role: role);

        // adding user in our database
        await _firestore
            .collection("akun")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Maaf tidak ada yang boleh kosong";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Maaf tidak ada yang boleh kosong";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    
  }
}
