import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctorbooking/dr_booking.dart';
import 'package:doximity/view/Appoinment/widget/schedule_card.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/feedback/feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    var doctorsCollec = FirebaseFirestore.instance.collection('doctors');
    String myUid = FirebaseAuth.instance.currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: StreamBuilder(
          stream: doctorsCollec
              .where('appliedPatients', arrayContains: myUid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CupertinoActivityIndicator();
            } else if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No Completes'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String drUid = snapshot.data!.docs[index].id;

                  return FutureBuilder(
                    future: doctorsCollec
                        .doc(drUid)
                        .collection('patient')
                        .doc(myUid)
                        .get(),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                      BookingDrDetails bookingDrDetails =
                          BookingDrDetails.fromJson(snap.data!.data()!);
                      return FadeInLeft(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: kGrayColor900,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FadeInDown(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          bookingDrDetails.profilePic
                                              .toString(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bookingDrDetails.drName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            bookingDrDetails.department,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                kHight20,
                                //--------------------------------------------------------
                                FadeInRight(
                                  delay: const Duration(milliseconds: 500),
                                  child: ScheduleCard(
                                      bookingDrDetails: bookingDrDetails),
                                ),
                                //---------------------------------------------------------
                                kHight20,
                                FadeInUp(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: kWhiteColor,
                                            border: Border.all(
                                              color: kGrayColor700,
                                              width: 1,
                                            ), //color of border
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Icon(
                                                  bookingDrDetails
                                                              .complete ==
                                                          true
                                                      ? Icons
                                                          .check_circle_outline_rounded
                                                      : Icons
                                                          .check_box_outline_blank,
                                                ),
                                              ),
                                              Text(
                                                bookingDrDetails.complete ==
                                                        true
                                                    ? 'C O M P L E T E D'
                                                    : 'N O T  C O M P L E T E D',
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      bookingDrDetails.complete == true
                                          ? Expanded(
                                              child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FeedBack(
                                                        bookingDrDetails:
                                                            bookingDrDetails,
                                                        drId: drUid,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Center(
                                                  child:
                                                      Text('Add Your Feedback'),
                                                ),
                                              ),
                                            )
                                          : const SizedBox()
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
              );
            } else if (snapshot.hasError) {
              log(
                'error${snapshot.hasError}'.toString(),
              );
              return Center(
                child: Text('Someting Went Wrong ${snapshot.error}'),
              );
            } else {
              return Container(
                height: 10,
                color: Colors.red,
              );
            }
          }),
    );
  }
}
