import 'package:doximity/model/doctorbooking/dr_booking.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  ScheduleCard({
    super.key,
    required this.bookingDrDetails,
  });

  final BookingDrDetails bookingDrDetails;

  final List<String> monthList = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "Mey",
    "Jun",
    "July",
    "Aug",
    "Spt",
    "Oct",
    "Nuv",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_today,
            color: kWhiteColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
              '${bookingDrDetails.date!.day.toString()} - ${monthList[bookingDrDetails.date!.month - 1].toString()} - ${bookingDrDetails.date!.year.toString()}'),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: kWhiteColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(bookingDrDetails.time),
          )
        ],
      ),
    );
  }
}
