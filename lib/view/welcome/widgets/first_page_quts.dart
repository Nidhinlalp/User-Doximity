import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/const/style/style.dart';
import 'package:flutter/material.dart';

class FirstPageQuts extends StatelessWidget {
  const FirstPageQuts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.60,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.white60,
              Colors.white,
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kHight30,
            Text(
              'Looking for a trusted \n Secured online Dr',
              style: kNormalStyle.copyWith(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            kHight30,
            Text(
              'A complane health app chat the allows customers get\n diagnased via chera phone',
              style: kNormalStyle.copyWith(
                fontSize: 15,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
