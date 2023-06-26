import 'package:animate_do/animate_do.dart';
import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/doctor_details_screen/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DrSpacialityPage extends StatelessWidget {
  const DrSpacialityPage({
    super.key,
    required this.specificDoctor,
  });

  final List<AllDoctorsDetails> specificDoctor;
  //'assets/images/dr.png'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Text(
          'Specialists',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kBlackColor900,
          ),
        ),
      ),
      body: specificDoctor.isEmpty
          ? const Center(
              child: Text('Doctors Not Available'),
            )
          : ListView.builder(
              itemCount: specificDoctor.length,
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
                              builder: (context) => DoctorDetailsScreen(
                                allDoctorsDetails: specificDoctor[index],
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: '${specificDoctor[index].drUid}pic',
                          child: FadeInRight(
                            child: Container(
                              height: 250,
                              width: 230,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    specificDoctor[index].profilePic,
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
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(index % 2 == 0 ? -170 : 170, 20),
                        child: FadeInLeft(
                          child: Container(
                            height: 110,
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
                                colors: [Colors.white, Colors.white],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: specificDoctor[index].name,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        specificDoctor[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ),
                                  ),
                                  kHight10,
                                  Text(
                                    specificDoctor[index].department,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(fontSize: 15),
                                  ),
                                  kHight10,
                                  RatingBar.builder(
                                    itemSize: 16,
                                    initialRating: 4.8,
                                    // double.parse(doctor!.doctorRating),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    itemPadding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: kYellowColor,
                                      );
                                    },
                                    onRatingUpdate: (rating) {
                                      debugPrint(rating.toString());
                                    },
                                    unratedColor: kGrayColor600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
