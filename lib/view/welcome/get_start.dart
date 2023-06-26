import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/welcome/widgets/first_page_quts.dart';
import 'package:doximity/view/welcome/widgets/get_start_button.dart';
import 'package:doximity/view/welcome/widgets/image_list_view.dart';
import 'package:doximity/view/welcome/widgets/the_name_of_app.dart';
import 'package:flutter/material.dart';

class GetStart extends StatelessWidget {
  const GetStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -10,
            left: -150,
            child: Row(
              children: [
                ImageListView(startIndex: 0),
                ImageListView(startIndex: 1),
                ImageListView(startIndex: 2),
              ],
            ),
          ),
          const TheNameOfApp(),
          const FirstPageQuts(),
          const GetStartElevetedButton(),
        ],
      ),
    );
  }
}
