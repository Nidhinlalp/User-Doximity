import 'package:doximity/view/const/style/style.dart';
import 'package:doximity/view/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(
      {super.key,
      required this.lastText,
      required this.textButton,
      required this.isSignUp});
  final String lastText;
  final String textButton;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lastText,
          style: kNormalStyle.copyWith(
              fontSize: 15, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: () {
            HapticFeedback.selectionClick();
            if (isSignUp) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Text(
            textButton,
            style: kNormalStyle.copyWith(
              fontSize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
