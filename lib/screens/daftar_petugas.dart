import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class DaftarPetugas extends StatefulWidget {
  const DaftarPetugas({super.key});

  @override
  State<DaftarPetugas> createState() => _DaftarPetugasState();
}

class _DaftarPetugasState extends State<DaftarPetugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text("Daftar Petugas",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500))),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('akun')
                .where('role', isEqualTo: 'petugas')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length < 1) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(
                      child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/empty.png'))),
                                 ),
                    ),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      String email = snapshot.data.docs[index]['email'];
                      String name = snapshot.data.docs[index]['name'];
                      String photoUrl = snapshot.data.docs[index]['photoUrl'];
                      String username = snapshot.data.docs[index]['username'];
                      String role = snapshot.data.docs[index]['role'];

                      return Padding(
                        padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
                        child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    photoUrl == ""
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                'https://i.stack.imgur.com/l60Hf.png'),
                                          )
                                        : CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.grey,
                                            backgroundImage:
                                                NetworkImage(photoUrl)),
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(email,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts.poppins(
                                                              textStyle: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(name,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: GoogleFonts.poppins(
                                                              textStyle: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))),
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
                            )),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
              );
            }),
      ),
    );
  }
}
