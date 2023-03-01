import 'package:aplikasi_ujikom_admin/global_methods.dart';
import 'package:aplikasi_ujikom_admin/screens/chat_screen/message_text_fild.dart';
import 'package:aplikasi_ujikom_admin/screens/chat_screen/single_img.dart';
import 'package:aplikasi_ujikom_admin/screens/chat_screen/single_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../firestore_methods.dart';
import '../../utils/utils.dart';

class HalamanChat extends StatefulWidget {
  final String currentUser;
  final String friendId;
  final String friendUsername;
  final String friendName;
  final String myImage;
  final String friendImage;
  // final String fcmtoken;
  final String myName;

  HalamanChat({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    required this.friendUsername,
    // required this.fcmtoken,
    required this.myName,
    required this.myImage,
  });

  @override
  State<HalamanChat> createState() => _HalamanChatState();
}

class _HalamanChatState extends State<HalamanChat> {
  final ScrollController messageController = ScrollController();
  bool isLoading = false;
  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            height: 72,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.friendImage),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 21,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.friendName,
                                  style: GoogleFonts.rubik(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 18,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.friendUsername,
                                  style: GoogleFonts.rubik(
                                      textStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                  context: context,
                  subtitle:
                      "Yakin menghapus percakapan dengan ${widget.friendName}?",
                  title: "Hapus Percakapan",
                  fct: () async {
                    await FirebaseFirestore.instance
                        .collection('akun')
                        .doc(widget.currentUser)
                        .collection('messages')
                        .doc(widget.friendId)
                        .delete();

                    final collection = await FirebaseFirestore.instance
                        .collection('akun')
                        .doc(widget.currentUser)
                        .collection('messages')
                        .doc(widget.friendId)
                        .collection('chats')
                        .get();

                    final batch = FirebaseFirestore.instance.batch();

                    for (final doc in collection.docs) {
                      batch.delete(doc.reference);
                    }

                    return batch.commit();
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sedang memuat data',
                  style: TextStyle(color: Colors.purple),
                ),
                CircularProgressIndicator(
                  color: Colors.purple,
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                    child: Container(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("akun")
                          .doc(widget.currentUser)
                          .collection('messages')
                          .doc(widget.friendId)
                          .collection('chats')
                          .orderBy("date", descending: false)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          FireStoreMethods.updateSend(
                              widget.currentUser, widget.friendId);
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            messageController.jumpTo(
                                messageController.position.maxScrollExtent);
                          });

                          return isLoading
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sedang memuat data',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    CircularProgressIndicator(
                                      color: Colors.purple,
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  controller: messageController,
                                  itemCount: snapshot.data.docs.length,
                                  reverse: false,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    bool isMe = snapshot.data.docs[index]
                                            ['senderId'] ==
                                        widget.currentUser;
                                    String messageType =
                                        snapshot.data.docs[index]['type'];
                                    Widget messageWidget = Container();

                                    switch (messageType) {
                                      case 'text':
                                        messageWidget = SingleMessage(
                                          message: snapshot.data.docs[index]
                                              ['message'],
                                          isMe: isMe,
                                          date: snapshot
                                              .data.docs[index]['date']
                                              .toDate(),
                                        );
                                        break;

                                      case 'img':
                                        messageWidget = SingleImage(
                                            message: snapshot.data.docs[index]
                                                ['message'],
                                            isMe: isMe,
                                            date: snapshot
                                                .data.docs[index]['date']
                                                .toDate());
                                        break;
                                    }

                                    return messageWidget;
                                  });
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: Colors.purple,
                        ));
                      }),
                )),
                MessageTextField(
                    widget.currentUser,
                    widget.friendId,
                    // widget.fcmtoken,
                    widget.friendImage,
                    widget.friendName,
                    widget.myName,
                    widget.myImage)
              ],
            ),
    );
  }
}

class ChatBoxPeople extends StatefulWidget {
  final String message;
  const ChatBoxPeople({Key? key, required this.message}) : super(key: key);

  @override
  State<ChatBoxPeople> createState() => _ChatBoxPeopleState();
}

class _ChatBoxPeopleState extends State<ChatBoxPeople> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/profil_dika.png'))),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: Text(
                widget.message,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBoxMe extends StatelessWidget {
  final String message;
  const ChatBoxMe({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 9),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.3),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
