
import 'package:aplikasi_ujikom_admin/global_methods.dart';
import 'package:aplikasi_ujikom_admin/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class DetailAduanAdmin extends StatefulWidget {
  const DetailAduanAdmin(
      {super.key,
      required this.judul,
      required this.deskripsi,
      required this.postId,
      required this.status,
      required this.imageUrl,
      required this.name,
      required this.tanggal});
  final String judul, deskripsi, postId, status, imageUrl, name;
  final DateTime tanggal;

  @override
  State<DetailAduanAdmin> createState() => _DetailAduanAdminState();
}

class _DetailAduanAdminState extends State<DetailAduanAdmin> {
  final _tanggapanController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _tanggapanController.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _uploadTanggapan() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      final _uuid = const Uuid().v4();
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('akun')
          .doc(user!.uid)
          .get();
      UserModel userModel = UserModel.fromSnap(userData);
      try {
        setState(() {
          _isLoading = true;
        });

        await FirebaseFirestore.instance
            .collection('aduan')
            .doc(widget.postId)
            .collection('tanggapan')
            .doc(_uuid)
            .set({
          'tanggapanId': _uuid,
          'photoUrl': userModel.photoUrl,
          'name': userModel.name,
          'userId': userModel.uid,
          'tanggapan': _tanggapanController.text,
          'createdAt': DateTime.now(),
        });
        _clearForm();
        Fluttertoast.showToast(
          msg: "Uploaded succefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          // backgroundColor: ,
          // textColor: ,
          // fontSize: 16.0
        );
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _clearForm() {
    _tanggapanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Widget status = Container();
    switch (widget.status) {
      case "di periksa":
        status = Text("Sedang Di Periksa",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)));
        break;
      case "di verifikasi":
        status = Text("Di Verifikasi",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)));
        break;
      case "di tolak":
        status = Text("Di Tolak",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)));
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconlyLight.arrowLeft2,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Text("Ditulis oleh ${widget.name}",
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold))),
                                  Spacer(),
                      IconButton(
                          onPressed: () {
                            GlobalMethods.warningDialog(
                              context: context,
                              subtitle: "Yakin menghapus Aduan?",
                              title: "Hapus Aduan",
                              fct: () async {
                                await FirebaseFirestore.instance
                                    .collection('aduan')
                                    .doc(widget.postId)
                                    .delete();

                                return Navigator.pop(context);
                              },
                            );
                          },
                          icon: Icon(IconlyLight.delete))
                    ],
                  ),
                ),
               Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Pada ${ DateFormat.yMd().add_jm()
                                                              .format(widget.tanggal)}",
                          style: GoogleFonts.rubik(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      status,
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          GlobalMethods.warningDialog(
                              title: "Tolak Aduan",
                              subtitle: "Yakin Tolak Aduan?",
                              fct: () async {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  await FirebaseFirestore.instance
                                      .collection('aduan')
                                      .doc(widget.postId)
                                      .update({'status': "di tolak"});

                                  Fluttertoast.showToast(
                                    msg: "Update succefully",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    // backgroundColor: ,
                                    // textColor: ,
                                    // fontSize: 16.0
                                  );
                                } on FirebaseException catch (error) {
                                  GlobalMethods.errorDialog(
                                      subtitle: '${error.message}',
                                      context: context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } catch (error) {
                                  GlobalMethods.errorDialog(
                                      subtitle: '$error', context: context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              context: context);
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("Tolak",
                                style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          GlobalMethods.warningDialog(
                              title: "Verifikasi Aduan",
                              subtitle: "Yakin Untuk Memferivikasi Aduan?",
                              fct: () async {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  await FirebaseFirestore.instance
                                      .collection('aduan')
                                      .doc(widget.postId)
                                      .update({'status': "di verifikasi"});

                                  Fluttertoast.showToast(
                                    msg: "Update succefully",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    // backgroundColor: ,
                                    // textColor: ,
                                    // fontSize: 16.0
                                  );
                                } on FirebaseException catch (error) {
                                  GlobalMethods.errorDialog(
                                      subtitle: '${error.message}',
                                      context: context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } catch (error) {
                                  GlobalMethods.errorDialog(
                                      subtitle: '$error', context: context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              context: context);
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("Verifikasi",
                                style: GoogleFonts.rubik(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(widget.judul,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ],
                  ),
                ),
               SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(widget.deskripsi,
                            style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.imageUrl == ""
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: 
                             Image.network(
                          widget.imageUrl,
                          fit: BoxFit.fill,
                        )
                      ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text("Tanggapan",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.rubik(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter a valid  Tanggapan";
                                      } else {
                                        return null;
                                      }
                                    },
                                    maxLines: 20,
                                    minLines: 1,
                                    controller: _tanggapanController,
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.purple),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        hintText: "Tanggapan Pengaduan",
                                        hintStyle: GoogleFonts.rubik(
                                            textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  _uploadTanggapan();
                                },
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text("Kirim",
                                        style: GoogleFonts.rubik(
                                            textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold))),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('aduan')
                              .doc(widget.postId)
                              .collection('tanggapan')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.docs.length < 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text("Belum ada Tanggapan",
                                      style: GoogleFonts.rubik(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500))),
                                );
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.docs.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    String name =
                                        snapshot.data.docs[index]['name'];
                                    String tanggapan =
                                        snapshot.data.docs[index]['tanggapan'];
                                    var time = snapshot
                                        .data.docs[index]['createdAt']
                                        .toDate();

                                    String userId =
                                        snapshot.data.docs[index]['userId'];
                                    String photoUrl =
                                        snapshot.data.docs[index]['photoUrl'];
                                    String tanggapanId = snapshot
                                        .data.docs[index]['tanggapanId'];

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 7),
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            photoUrl == ""
                                                ? CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: NetworkImage(
                                                        'https://i.stack.imgur.com/l60Hf.png'),
                                                  )
                                                : CircleAvatar(
                                                    radius: 25,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    backgroundImage:
                                                        NetworkImage(photoUrl)),
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(name,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.rubik(
                                                                      textStyle: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold))),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                  tanggapan,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: GoogleFonts.rubik(
                                                                      textStyle: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w400))),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
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
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
