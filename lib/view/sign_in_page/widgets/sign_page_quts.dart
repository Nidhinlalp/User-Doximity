import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/const/style/style.dart';
import 'package:flutter/material.dart';

class SingInPageQuts extends StatelessWidget {
  const SingInPageQuts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign in to your account',
                style: kNormalStyle.copyWith(
                    fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          kHight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome  back , Sign in to  your  account .',
                style: kNormalStyle.copyWith(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
