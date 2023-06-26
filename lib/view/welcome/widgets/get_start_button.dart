import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetStartElevetedButton extends StatelessWidget {
  const GetStartElevetedButton({
    super.key,
  });

  static bool getStartedPressed = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: 30,
      right: 30,
      child: FlipInY(
        child: SizedBox(
          height: 50,
          width: 310,
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.vibrate();
              getStartedPressed = true;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              overlayColor: MaterialStateProperty.all(Colors.black),
              backgroundColor: MaterialStateProperty.all(kButtonColor),
            ),
            child: const Text('Get Start'),
          ),
        ),
      ),
    );
  }
}
