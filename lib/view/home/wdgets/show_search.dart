// import 'package:doximity/view_model/search/search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:provider/provider.dart';

// import '../../const/color/colors.dart';
// import '../../const/size/size.dart';

// class ShowSearch extends StatelessWidget {
//   const ShowSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Search>(builder: (context, value, child) {
//       return Padding(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Container(
//             color: Colors.transparent,
//             height: 80,
//             width: MediaQuery.of(context).size.width - 32,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Hero(
//                   tag: '${value.searchResult[0]['drUid']}pic',
//                   child: Container(
//                     width: 88,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(
//                           doctor!.profilepic,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 Flexible(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Hero(
//                         tag: doctor!.name,
//                         child: Material(
//                           color: Colors.transparent,
//                           child: Text(
//                             'Dr.${doctor!.name}',
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                             style: Theme.of(context).textTheme.headlineMedium,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         '${doctor!.department}.${doctor!.hospital}.${doctor!.location}',
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                         style: Theme.of(context).textTheme.headlineSmall,
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width - 136,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 RatingBar.builder(
//                                   itemSize: 16,
//                                   initialRating: 4.8,
//                                   // double.parse(doctor!.doctorRating),
//                                   minRating: 1,
//                                   direction: Axis.horizontal,
//                                   itemCount: 5,
//                                   itemPadding: EdgeInsets.zero,
//                                   itemBuilder: (context, index) {
//                                     return const Icon(
//                                       Icons.star,
//                                       color: kYellowColor,
//                                     );
//                                   },
//                                   onRatingUpdate: (rating) {
//                                     debugPrint(rating.toString());
//                                   },
//                                   unratedColor: kGrayColor600,
//                                 ),
//                                 const SizedBox(
//                                   width: 4,
//                                 ),
//                                 Text(
//                                   '(${doctor!.patience})',
//                                   style: Theme.of(context).textTheme.bodyMedium,
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       kHight10
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ));
//     });
//   }
// }
