import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/doctor_details_screen/widgets/chat_and_appoinment_botton.dart';
import 'package:doximity/view/doctor_details_screen/widgets/ex_ps_ra_section.dart';
import 'package:doximity/view_model/favorite/favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.allDoctorsDetails});

  final AllDoctorsDetails allDoctorsDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: kBgcolor,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kBlackColor900,
                    size: 25,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        log(allDoctorsDetails.toString());
                        context
                            .read<FavorteDr>()
                            .toggleFavorite(allDoctorsDetails);
                      },
                      icon:
                          context.watch<FavorteDr>().isExist(allDoctorsDetails)
                              ? const Icon(
                                  Icons.bookmark,
                                  size: 28,
                                  color: kBlackColor900,
                                )
                              : const Icon(
                                  Icons.bookmark_add_outlined,
                                  size: 28,
                                  color: kBlackColor900,
                                ),
                    ),
                  )
                ],
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  title: Hero(
                    tag: allDoctorsDetails.name,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Dr.${allDoctorsDetails.name}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  background: Hero(
                    tag: '${allDoctorsDetails.drUid}pic',
                    child: Image.network(
                      allDoctorsDetails.profilePic,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                floating: true,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${allDoctorsDetails.department}.${allDoctorsDetails.hospital}.${allDoctorsDetails.hospital}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        '${allDoctorsDetails.name}. ${allDoctorsDetails.explanation}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kGrayColor700,
                              fontFamily:
                                  GoogleFonts.sourceSansPro().fontFamily,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w400,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                      ),
                      // const Spacer(),
                      SizedBox(
                        height: 500,
                        child:
                            UserComents(allDoctorsDetails: allDoctorsDetails),
                      ),

                      // const Spacer(),
                      kHight50,
                    ],
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: kWhiteColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Exp_Ps_Ra_Section(
                        doctorYearOfExperince: allDoctorsDetails.experience,
                        doctorNumberOfPatient: allDoctorsDetails.patience,
                        doctorRating: '0.0',
                      ),
                    ),
                    kHight10,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chat_And_Appoinment_Botton(
                        allDoctorsDetails: allDoctorsDetails,
                        times: allDoctorsDetails.times,
                        drUid: allDoctorsDetails.drUid,
                        doctorImage: allDoctorsDetails.profilePic,
                        doctorName: allDoctorsDetails.name,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserComents extends StatelessWidget {
  const UserComents({
    super.key,
    required this.allDoctorsDetails,
  });

  final AllDoctorsDetails allDoctorsDetails;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('feedback')
          .doc(allDoctorsDetails.drUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.data!.data() == null) {
          return const Center(
            child: Text("No reviews"),
          );
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            log(snapshot.data!.data()!['feedback'][index]['text'].toString());
            return ListTile(
              title: Text(
                snapshot.data!
                    .data()!['feedback'][index]['userName']
                    .toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Text(
                snapshot.data!.data()!['feedback'][index]['text'].toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data!
                    .data()!['feedback'][index]['userImage']
                    .toString()),
              ),
            );
          },
          itemCount: snapshot.data!.data()!['feedback'].length,
        );
      },
    );
  }
}
