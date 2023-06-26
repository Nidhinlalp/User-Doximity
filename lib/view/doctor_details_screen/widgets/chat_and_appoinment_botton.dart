import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/booking_page/booking_page.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Chat_And_Appoinment_Botton extends StatelessWidget {
  const Chat_And_Appoinment_Botton({
    super.key,
    required this.times,
    this.drUid,
    required this.doctorImage,
    required this.doctorName,
    required this.allDoctorsDetails,
  });
  final List times;
  final String? drUid;
  final String doctorImage;
  final String doctorName;
  final AllDoctorsDetails allDoctorsDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // GestureDetector(
        //   // onTap: () {
        //   //   Navigator.push(
        //   //     context,
        //   //     MaterialPageRoute(
        //   //       builder: (context) => ChatScreen(
        //   //         allDoctorsDetails: allDoctorsDetails,
        //   //         doctoId: drUid!,
        //   //         doctorImage: doctorImage,
        //   //         doctorName: doctorName,
        //   //       ),
        //   //     ),
        //   //   );
        //   // },
        //   child: Container(
        //     height: 56,
        //     width: 56,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(16),
        //       color: kBlueColor,
        //       image: const DecorationImage(
        //         image: AssetImage(
        //           'assets/icons/Icons-chat.png',
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(
        //   width: 16,
        // ),
        Expanded(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    times: times,
                    drUid: drUid!,
                    allDoctorsDetails: allDoctorsDetails,
                  ),
                ),
              );
              // openCheckout('Nidhin', '2500');
            },
            child: Container(
              height: 56,
              width: MediaQuery.of(context).size.width - 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kGreenColor,
              ),
              child: Center(
                child: Text(
                  'Make an Appoinment',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: kWhiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
