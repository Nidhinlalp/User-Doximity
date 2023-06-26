import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/doctor_details_screen/doctor_details.dart';
import 'package:doximity/view_model/favorite/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../view_model/feedback/feedback.dart';
import '../home/wdgets/top_dr_card.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final CollectionReference favDoctors =
      FirebaseFirestore.instance.collection('favorateDoctors');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0,
          centerTitle: true,
          title: BounceInDown(
            child: Text(
              'My Favorite Doctors',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        body: StreamBuilder(
          stream: favDoctors.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                final tempList = snapshot.data!.docs.where((element) =>
                    element.id == FirebaseAuth.instance.currentUser!.uid);
                Object? favDoctorsMap;
                if (tempList.isNotEmpty) {
                  favDoctorsMap = tempList.first.data();
                }

                log('$favDoctorsMap');
                List<AllDoctorsDetails> favDoctors = [];
                if (favDoctorsMap != null) {
                  for (var element in (favDoctorsMap
                      as Map<String, dynamic>?)!['favourite']) {
                    favDoctors.add(AllDoctorsDetails.fromJson(element));
                  }
                }

                return favDoctors.isEmpty
                    ? const Center(
                        child: Text('No Favorites '),
                      )
                    : snapshot.data!.docs.isEmpty
                        ? Center(
                            child: Text('no data'),
                          )
                        : ListView.builder(
                            itemCount: favDoctors.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0,
                                  vertical: 50,
                                ),
                                child: Stack(
                                    alignment: index % 2 == 0
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DoctorDetailsScreen(
                                                allDoctorsDetails:
                                                    favDoctors[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Hero(
                                          tag: '${favDoctors[index].drUid}pic',
                                          child: FadeInRight(
                                            child: Container(
                                              height: 250,
                                              width: 230,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    favDoctors[index]
                                                        .profilePic,
                                                  ),
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.blueAccent.shade100,
                                                    Colors.white10,
                                                  ],
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: Offset(
                                            index % 2 == 0 ? -170 : 170, 20),
                                        child: FadeInLeft(
                                          child: Container(
                                            height: 120,
                                            width: 160,
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.white,
                                                  Colors.white,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Hero(
                                                        tag: favDoctors[index]
                                                            .name,
                                                        child: Material(
                                                          child: Text(
                                                            favDoctors[index]
                                                                .name,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineMedium,
                                                          ),
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          context
                                                              .read<FavorteDr>()
                                                              .clearFav();
                                                        },
                                                        icon: const Icon(
                                                          Icons.bookmark,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    favDoctors[index]
                                                        .department,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(fontSize: 17),
                                                  ),
                                                  kHight10,
                                                  StreamBuilder<QuerySnapshot>(
                                                    stream: context
                                                        .read<
                                                            FeedbackProvider>()
                                                        .ratingsCollection
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (!snapshot.hasData) {
                                                        return const Row(
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  kGrayColor600,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  kGrayColor600,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              color:
                                                                  kGrayColor600,
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      List<DocumentSnapshot>
                                                          documents =
                                                          snapshot.data!.docs;
                                                      double totalRating = 0;
                                                      for (var document
                                                          in documents) {
                                                        totalRating +=
                                                            document['rating'];
                                                      }
                                                      double averageRating =
                                                          0.0;
                                                      if (averageRating !=
                                                          0.0) {
                                                        averageRating =
                                                            totalRating /
                                                                documents
                                                                    .length;
                                                      }

                                                      if (snapshot.hasData) {
                                                        return Row(
                                                          children: [
                                                            RatingBarr(
                                                              rating:
                                                                  averageRating,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
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
                                          ),
                                        ),
                                      ),
                                    ]),
                              );
                            },
                          );
              } else {
                return const Center(child: Text('No Favorites'));
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('Someting Went Wrong'));
            } else {
              return const Center(
                child: Text('Chek your internet connection'),
              );
            }
          },
        ),
      ),
    );
  }
}
