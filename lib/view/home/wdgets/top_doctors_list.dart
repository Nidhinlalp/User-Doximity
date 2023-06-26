import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/doctor_details_screen/doctor_details.dart';
import 'package:doximity/view/home/wdgets/top_dr_card.dart';
import 'package:doximity/view_model/drdetails/dr_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../view_model/feedback/feedback.dart';
import '../../../view_model/search/search.dart';
import '../../const/color/colors.dart';
import '../../const/size/size.dart';

class TopDoctorsList extends StatefulWidget {
  const TopDoctorsList({super.key});

  @override
  State<TopDoctorsList> createState() => _TopDoctorsListState();
}

class _TopDoctorsListState extends State<TopDoctorsList> {
  List<AllDoctorsDetails> ogDoctors = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getAlldoctorStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return getShimmerLoading();
        } else if (snapshot.hasData) {
          ogDoctors = snapshot.data!
              .where((element) => element.requst == true)
              .toList();

          return context.watch<Search>().textEditingController.text.isEmpty
              ? ogDoctors.isEmpty
                  ? const Center(
                      child: SizedBox(
                        height: 100,
                        child: Center(
                          child: Text('No Dr. Available'),
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ogDoctors.length,
                      itemBuilder: (context, index) {
                        final doctorData = ogDoctors;
                        return GestureDetector(
                          onTap: () {
                            log(doctorData[index].consaltaionFee.toString());
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
                    )
              : Consumer<Search>(
                  builder: (context, value, child) {
                    return value.searchResult.isEmpty
                        ? const Center(
                            child: Text('No Result fount'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.searchResult.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorDetailsScreen(
                                        allDoctorsDetails:
                                            AllDoctorsDetails.fromMap(
                                                value.searchResult[index]),
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    color: Colors.transparent,
                                    height: 80,
                                    width:
                                        MediaQuery.of(context).size.width - 32,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Hero(
                                          tag:
                                              '${value.searchResult[index]['drUid']}pic',
                                          child: Container(
                                            width: 88,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  value.searchResult[index]
                                                      ['profilePic'],
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Hero(
                                                tag: value.searchResult[index]
                                                    ['name'],
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Text(
                                                    'Dr.${value.searchResult[index]['name']}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineMedium,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${value.searchResult[index]['department']}.${value.searchResult[index]['hospital']}.${value.searchResult[index]['location']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                width: MediaQuery.of(context)
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
                                                          return Row(
                                                            children: const [
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
                                                              document[
                                                                  'rating'];
                                                        }
                                                        double averageRating =
                                                            totalRating /
                                                                documents
                                                                    .length;
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
                                                              Text(
                                                                '(${value.searchResult[index]['patience']})',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium,
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

Shimmer getShimmerLoading() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 18.0,
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 14.0,
                color: Colors.white,
              )
            ],
          ),
        )
      ],
    ),
  );
}
