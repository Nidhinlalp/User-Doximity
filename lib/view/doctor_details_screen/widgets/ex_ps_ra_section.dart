import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/feedback/feedback.dart';

// ignore: camel_case_types
class Exp_Ps_Ra_Section extends StatelessWidget {
  const Exp_Ps_Ra_Section({
    super.key,
    required this.doctorYearOfExperince,
    required this.doctorNumberOfPatient,
    required this.doctorRating,
  });

  final String doctorYearOfExperince;
  final String doctorNumberOfPatient;
  final String doctorRating;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Experience',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kBlackColor900, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctorYearOfExperince,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kBlueColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'yr',
                    style: Theme.of(context).textTheme.headlineSmall!,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          const VerticalDivider(
            thickness: 1,
            color: kGrayColor400,
          ),
          Column(
            children: [
              Text(
                'Patients',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kBlackColor900, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    doctorNumberOfPatient,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: kBlueColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'ps',
                    style: Theme.of(context).textTheme.headlineSmall!,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          const VerticalDivider(
            thickness: 1,
            color: kGrayColor400,
          ),
          Column(
            children: [
              Text(
                'Rating',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: kBlackColor900, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8,
              ),
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
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  double totalRating = 0;
                  for (var document in documents) {
                    totalRating += document['rating'];
                  }
                  double averageRating = totalRating / documents.length;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        snapshot.data == null
                            ? doctorRating
                            : averageRating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kBlueColor,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
