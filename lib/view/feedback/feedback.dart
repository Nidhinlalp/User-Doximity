import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:doximity/model/doctorbooking/dr_booking.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/feedback/widget/app_head.dart';
import 'package:doximity/view/feedback/widget/custom_appbar.dart';

import '../../view_model/feedback/feedback.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({
    super.key,
    required this.bookingDrDetails,
    required this.drId,
  });
  static TextEditingController feedback = TextEditingController();
  final BookingDrDetails bookingDrDetails;
  final String drId;

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  double rated = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const AppHeader(),
            const Positioned(
              top: -380,
              left: -187,
              child: Opacity(
                opacity: 0.9,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CustomAppbar(),
                    kHight30,
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        widget.bookingDrDetails.profilePic.toString(),
                      ),
                    ),
                    kHight20,
                    Text(
                      'Dr.${widget.bookingDrDetails.drName.toString()}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 24),
                    ),
                    kHight20,
                    const Divider(
                      color: kGrayColor700,
                    ),
                    kHight30,
                    Text(
                      'How is your  Experience',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    kHight20,
                    RatingBar.builder(
                      initialRating: 0.1,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          rated = value;
                        });
                      },
                    ),
                    kHight30,
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            offset: const Offset(0.0, 15.0),
                            color: kBlackColor800.withAlpha(20),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: FeedBack.feedback,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add your feedback'),
                      ),
                    ),
                    kHight50,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Submit',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: kGreenColor, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        RoundedButton(
                          icon: const Icon(Icons.arrow_forward),
                          iconColor: kWhiteColor,
                          bgColor: kGreenColor,
                          tap: () async {
                            await context
                                .read<FeedbackProvider>()
                                .addFeedBack(widget.drId, rated);
                            log(rated.toString());
                            FeedBack.feedback.clear();
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
