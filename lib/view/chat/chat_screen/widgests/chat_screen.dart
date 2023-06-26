import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/chat_user_model/chat_room_model.dart';
import 'package:doximity/model/doctormodel/chat_user_model/massage_model.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/chat/chat.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(
      {super.key,
      required this.doctoId,
      required this.doctorName,
      required this.doctorImage,
      required this.allDoctorsDetails,
      required this.chatroom});

  // final UserModel curentUser;
  final String doctoId;
  final String doctorName;
  final String doctorImage;
  final AllDoctorsDetails allDoctorsDetails;
  final ChatRoomModel chatroom;
  final List<String> monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "Mey",
    "Jun",
    "July",
    "Aug",
    "Spt",
    "Oct",
    "Nuv",
    "Dec"
  ];
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();
    if (msg != '') {
      //send message
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: FirebaseAuth.instance.currentUser!.uid,
          createdon: DateTime.now(),
          seen: false,
          text: msg);
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomid)
          .collection('messages')
          .doc(newMessage.messageid)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = msg;
      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomid)
          .set(widget.chatroom.toMap());
      log("message send");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kBlackColor900,
          ),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Hero(
                tag: '${widget.allDoctorsDetails.drUid}pic',
                child: Image.network(
                  widget.doctorImage,
                  height: 35,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Hero(
              tag: widget.doctorName,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  widget.doctorName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chatrooms')
                    .doc(widget.chatroom.chatroomid)
                    .collection('messages')
                    .orderBy('createdon', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot dataSnapshot =
                          snapshot.data as QuerySnapshot;
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: dataSnapshot.docs.length,
                        itemBuilder: (context, index) {
                          MessageModel currentMessage = MessageModel.fromMap(
                            dataSnapshot.docs[index].data()
                                as Map<String, dynamic>,
                          );
                          return FlipInY(
                            child: Row(
                              mainAxisAlignment: (currentMessage.sender ==
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: kGrayColor400,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('yMMMEd').format(
                                              currentMessage.createdon!,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            DateFormat('KK:mm a').format(
                                                currentMessage.createdon!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                      kHight10,
                                      Text(
                                        currentMessage.text.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'An error occured ! Please check your internnet connection'),
                      );
                    } else {
                      return const Center(
                        child: Text('Say Hi Your Dr'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Container(
            color: kWhiteColor,
            padding: const EdgeInsetsDirectional.all(8),
            child: Row(
              children: [
                Expanded(
                  child: FadeInLeft(
                    child: TextField(
                      maxLines: null,
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: "Type your Message",
                        fillColor: Colors.grey[100],
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0),
                          gapPadding: 10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ZoomIn(
                  child: GestureDetector(
                    onTap: () async {
                      sendMessage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kBlueColor,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
