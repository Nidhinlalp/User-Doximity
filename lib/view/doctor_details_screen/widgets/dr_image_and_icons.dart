import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';

class DrImageAndIcons extends StatelessWidget {
  const DrImageAndIcons({
    super.key,
    required this.doctorPicture,
  });

  final String doctorPicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: kGrayColor600,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/$doctorPicture'),
        ),
      ),
      // child: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           child: Container(
      //             height: 24,
      //             width: 24,
      //             decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                 image: AssetImage('assets/icons/back-icon.png'),
      //               ),
      //             ),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             // Navigator.pop(context);
      //           },
      //           child: Container(
      //             height: 30,
      //             width: 30,
      //             decoration: const BoxDecoration(
      //               image: DecorationImage(
      //                 image: AssetImage(
      //                   'assets/icons/Icons-Artboard 31 1.png',
      //                 ),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
