import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/style/style.dart';

import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SingInButton extends StatelessWidget {
  const SingInButton(
      {super.key,
      required this.name,
      required this.onPressed,
      required this.formKey});
  final void Function() onPressed;
  final String name;

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 310,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.heavyImpact();
          if (formKey.currentState!.validate()) {
            onPressed();
          }
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
        child: context.watch<AuthProvider>().loading == true
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                name,
                style: kNormalStyle.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
