import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/feedback/feedback.dart';

class TopDoctorCard extends StatelessWidget {
  const TopDoctorCard({super.key, this.doctor});
  final AllDoctorsDetails? doctor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        color: Colors.transparent,
        height: 80,
        width: MediaQuery.of(context).size.width - 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: '${doctor!.drUid}pic',
              child: Container(
                width: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      doctor!.profilePic,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: doctor!.name,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        'Dr.${doctor!.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Text(
                    '${doctor!.department}.${doctor!.hospital}.${doctor!.location}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 136,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: context
                              .read<FeedbackProvider>()
                              .ratingsCollection
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
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
                            List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            double totalRating = 0;
                            for (var document in documents) {
                              totalRating += document['rating'];
                            }
                            double averageRating = 0.0;
                            if (totalRating != 0) {
                              averageRating = totalRating / documents.length;
                            }

                            if (snapshot.hasData) {
                              // return Text('data');
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
                                    '(${doctor!.patience})',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              );
                            } else if (snapshot.hasError) {
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
    );
  }
}
// ignore: must_be_immutable

// ignore: must_be_immutable
class RatingBarr extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;
  RatingBarr({
    super.key,
    required this.rating,
    required this.size,
    this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];
    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (var i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(
          Icon(
            Icons.star,
            color: Colors.yellowAccent,
            size: size,
          ),
        );
      } else if (i == realNumber) {
        starList.add(
          SizedBox(
            height: size,
            width: size,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: size,
                ),
                ClipRect(
                  clipper: _Clipper(part: partNumber),
                  child: Icon(
                    Icons.star,
                    color: kGrayColor900,
                    size: size,
                  ),
                )
              ],
            ),
          ),
        );
      } else {
        starList.add(
          Icon(
            Icons.star,
            color: kGrayColor900,
            size: size,
          ),
        );
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}
