import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctorbooking/dr_booking.dart';
import 'package:doximity/view/Appoinment/widget/schedule_card.dart';
import 'package:doximity/view/const/alert_box/alertbx.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view_model/booking/booking_dr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstTab extends StatelessWidget {
  const FirstTab({super.key});

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
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No bookings'),
              );
            } else if (snapshot.hasData) {
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
                        return FadeInRight(
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
                                            bookingDrDetails.profilePic,
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
                                  FadeInLeft(
                                    delay: const Duration(milliseconds: 500),
                                    child: ScheduleCard(
                                      bookingDrDetails: bookingDrDetails,
                                    ),
                                  ),
                                  //---------------------------------------------------------
                                  kHight20,
                                  bookingDrDetails.decline == true
                                      ? FadeInLeft(
                                          delay:
                                              const Duration(milliseconds: 500),
                                          child: Row(
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
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Icon(
                                                          Icons
                                                              .cancel_presentation_rounded,
                                                        ),
                                                      ),
                                                      Text('C E N C E L D')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : FadeInUp(
                                          delay:
                                              const Duration(milliseconds: 500),
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
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Icon(
                                                          bookingDrDetails
                                                                      .acept ==
                                                                  true
                                                              ? Icons.fork_right
                                                              : Icons
                                                                  .pending_actions_outlined,
                                                        ),
                                                      ),
                                                      Text(
                                                        bookingDrDetails
                                                                    .acept ==
                                                                true
                                                            ? 'Acepted'
                                                            : 'Pending',
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              bookingDrDetails.acept == true
                                                  ? const SizedBox()
                                                  : Expanded(
                                                      child: OutlinedButton(
                                                        onPressed: () {
                                                          showQuickAlert(
                                                            context,
                                                            'Celcel',
                                                            'Are you Shower To Cencel',
                                                            () => context
                                                                .read<
                                                                    BookingProvider>()
                                                                .decline(drUid),
                                                          );
                                                        },
                                                        child: Text(
                                                          'Cancel',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Something went rong');
            } else {
              return const Text('chek your internet');
            }
          }),
    );
  }
}
