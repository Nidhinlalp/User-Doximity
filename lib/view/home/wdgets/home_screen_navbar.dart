import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/view/complete_profile/edite_profile.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/home/wdgets/top_doctors_list.dart';
import 'package:doximity/view/home/wdgets/top_dr_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../../view_model/drdetails/dr_details.dart';

import '../../../view_model/user_profile/user_profile.dart';
import '../../doctor_details_screen/doctor_details.dart';

class HomeScreenNavbar extends StatelessWidget {
  const HomeScreenNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasData) {
                  return SizedBox(
                    width: 35,
                    height: 35,
                    child: GestureDetector(
                      onTap: () async {
                        var userName =
                            await context.read<UserProfile>().getUserName();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CompleteProfileEdite(userNames: userName),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: kWhiteColor,
                        backgroundImage: NetworkImage(
                          snapshot.data!.data()!['profilePic'].toString(),
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went rong'));
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              },
            ),
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: const Icon(
                IconlyLight.search,
                size: 30,
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(
          IconlyLight.close_square,
          size: 30,
          shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
          color: Colors.black54,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        IconlyLight.arrow_left,
        size: 30,
        shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 15.0)],
        color: Colors.black54,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: getAlldoctorStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return getShimmerLoading();
        } else if (snapshot.hasData) {
          var ogDoctors = query.isEmpty
              ? snapshot.data!
                  .where((element) => element.requst == true)
                  .toList()
              : snapshot.data!
                  .where(
                      (element) => element.name.toLowerCase().startsWith(query))
                  .toList();

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ogDoctors.isEmpty
                ? const Center(
                    child: Text('No Rusultfound'),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ogDoctors.length,
                    itemBuilder: (context, index) {
                      final doctorData = ogDoctors;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDetailsScreen(
                                allDoctorsDetails: doctorData[index],
                              ),
                            ),
                          );
                        },
                        child: TopDoctorCard(doctor: doctorData[index]),
                      );
                    },
                  ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Someting Want Wrong'));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
