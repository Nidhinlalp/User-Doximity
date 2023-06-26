import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doximity/view/const/image/intro_image.dart';
import 'package:doximity/view/welcome/widgets/get_start_button.dart';
import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  final int startIndex;
  ImageListView({super.key, required this.startIndex});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        log('starting scrolling');
        if (GetStartElevetedButton.getStartedPressed == true) {
          timer.cancel();
        }

        if (scrollController.offset ==
            scrollController.position.minScrollExtent) {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 17), curve: Curves.linear);
        } else if (scrollController.offset ==
            scrollController.position.maxScrollExtent) {
          scrollController.animateTo(scrollController.position.minScrollExtent,
              duration: const Duration(seconds: 17), curve: Curves.linear);
        }
      },
    );

    return Transform.rotate(
      angle: 1.96 * (22 / 7),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        height: MediaQuery.of(context).size.height * 0.60,
        child: ListView.builder(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          reverse: startIndex == 1,
          itemCount: 4,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: photos[startIndex + index].imageUrl,
              imageBuilder: (con5text, imageProvider) {
                return Container(
                  margin: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                    top: 10.0,
                  ),
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
