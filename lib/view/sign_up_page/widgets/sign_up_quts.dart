import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/const/style/style.dart';
import 'package:flutter/material.dart';

class SignUpPageQuts extends StatelessWidget {
  const SignUpPageQuts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Join us to start searching',
              style: kNormalStyle.copyWith(
                  fontSize: 25, fontWeight: FontWeight.w700, letterSpacing: 1),
            ),
          ],
        ),
        kHight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your information is safe with us',
              style: kNormalStyle.copyWith(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
