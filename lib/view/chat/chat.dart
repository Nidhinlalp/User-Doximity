import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/chat_user_model/chat_room_model.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/chat/chat_screen/widgests/chat_screen.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/home/wdgets/search_textfeild.dart';
import 'package:doximity/view/home/wdgets/top_doctors_list.dart';
import 'package:doximity/view/home/wdgets/top_dr_card.dart';
import 'package:doximity/view_model/drdetails/dr_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../view_model/feedback/feedback.dart';
import '../../view_model/search/search.dart';

var uuid = const Uuid();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<ChatRoomModel?> getChatroomModel(AllDoctorsDetails targetUser) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where('participants.${FirebaseAuth.instance.currentUser!.uid}',
            isEqualTo: true)
        .where('participants.${targetUser.drUid}', isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatRoom = existingChatroom;
      log('chatrom alredy created');
    } else {
      log('chatrom not created');
      ChatRoomModel newChatroom = ChatRoomModel(
        chatroomid: uuid.v1(),
        lastMessage: '',
        participants: {
          FirebaseAuth.instance.currentUser!.uid: true,
          targetUser.drUid.toString(): true
        },
      );

      await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      chatRoom = newChatroom;
      log('new chat room created');
    }
    return chatRoom;
  }

  List<AllDoctorsDetails> ogDoctors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: BounceInDown(
          child: Text(
            'My Chats',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getAlldoctorStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getShimmerLoading();
          } else if (snapshot.hasData) {
            ogDoctors = snapshot.data!
                .where((element) => element.requst == true)
                .toList();
            return ogDoctors.isEmpty
                ? const Center(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('No Dr. Available'),
                      ),
                    ),
                  )
                : Scaffold(
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            kHight10,
                            FadeInLeft(child: const SearchFeildInHome()),
                            kHight30,
                            context
                                    .watch<Search>()
                                    .textEditingController
                                    .text
                                    .isEmpty
                                ? FadeInRight(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: ogDoctors.length,
                                      itemBuilder: (context, index) {
                                        final doctorData = ogDoctors;
                                        return GestureDetector(
                                          onTap: () async {
                                            ChatRoomModel? chatroomModel =
                                                await getChatroomModel(
                                                    doctorData[index]);
                                            if (chatroomModel != null &&
                                                mounted) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatScreen(
                                                    doctoId: doctorData[index]
                                                        .drUid
                                                        .toString(),
                                                    doctorImage:
                                                        doctorData[index]
                                                            .profilePic,
                                                    doctorName:
                                                        doctorData[index].name,
                                                    allDoctorsDetails:
                                                        doctorData[index],
                                                    chatroom: chatroomModel,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: TopDoctorCard(
                                            doctor: doctorData[index],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Consumer<Search>(
                                    builder: (context, value, child) {
                                      return value.searchResult.isEmpty
                                          ? const Center(
                                              child: Text('No Result fount'),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  value.searchResult.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 16,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      ChatRoomModel?
                                                          chatroomModel =
                                                          await getChatroomModel(
                                                        AllDoctorsDetails
                                                            .fromMap(
                                                          value.searchResult[
                                                              index],
                                                        ),
                                                      );
                                                      if (chatroomModel !=
                                                              null &&
                                                          mounted) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    ChatScreen(
                                                              doctoId: value
                                                                  .searchResult[
                                                                      index]
                                                                      ['drUid']
                                                                  .toString(),
                                                              doctorImage: value
                                                                          .searchResult[
                                                                      index][
                                                                  'profilePic'],
                                                              doctorName: value
                                                                      .searchResult[
                                                                  index]['name'],
                                                              allDoctorsDetails:
                                                                  AllDoctorsDetails
                                                                      .fromMap(
                                                                value.searchResult[
                                                                    index],
                                                              ),
                                                              chatroom:
                                                                  chatroomModel,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      height: 80,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              32,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Hero(
                                                            tag:
                                                                '${value.searchResult[index]['drUid']}pic',
                                                            child: Container(
                                                              width: 88,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image:
                                                                      NetworkImage(
                                                                    value.searchResult[
                                                                            index]
                                                                        [
                                                                        'profilePic'],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 16,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Hero(
                                                                  tag: value.searchResult[
                                                                          index]
                                                                      ['name'],
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Text(
                                                                      'Dr.${value.searchResult[index]['name']}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      maxLines:
                                                                          1,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headlineMedium,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${value.searchResult[index]['department']}.${value.searchResult[index]['hospital']}.${value.searchResult[index]['location']}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headlineSmall,
                                                                ),
                                                                const Spacer(),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      136,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      StreamBuilder<
                                                                          QuerySnapshot>(
                                                                        stream: context
                                                                            .read<FeedbackProvider>()
                                                                            .ratingsCollection
                                                                            .snapshots(),
                                                                        builder: (BuildContext
                                                                                context,
                                                                            AsyncSnapshot<QuerySnapshot>
                                                                                snapshot) {
                                                                          if (!snapshot
                                                                              .hasData) {
                                                                            return const Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: kGrayColor600,
                                                                                ),
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: kGrayColor600,
                                                                                ),
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: kGrayColor600,
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }
                                                                          List<DocumentSnapshot>
                                                                              documents =
                                                                              snapshot.data!.docs;
                                                                          double
                                                                              totalRating =
                                                                              0;
                                                                          for (var document
                                                                              in documents) {
                                                                            totalRating +=
                                                                                document['rating'];
                                                                          }
                                                                          double
                                                                              averageRating =
                                                                              totalRating / documents.length;
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Row(
                                                                              children: [
                                                                                RatingBarr(
                                                                                  rating: averageRating,
                                                                                  size: 20,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 4,
                                                                                ),
                                                                                Text(
                                                                                  '(${value.searchResult[index]['patience']})',
                                                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                                                )
                                                                              ],
                                                                            );
                                                                          } else if (snapshot
                                                                              .hasError) {
                                                                            return const Center(
                                                                              child: Text(''),
                                                                            );
                                                                          } else {
                                                                            return const Center(
                                                                              child: Text(''),
                                                                            );
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                kHight10
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                  );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Someting Want Wrong'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
