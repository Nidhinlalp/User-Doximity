import 'package:doximity/view/const/style/style.dart';
import 'package:flutter/material.dart';

class TheNameOfApp extends StatelessWidget {
  const TheNameOfApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.09,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "Doximity",
            textAlign: TextAlign.center,
            style: kTitleStyle.copyWith(
                fontWeight: FontWeight.w900, color: Colors.white, fontSize: 40),
          ),
          Text(
            "Doximity",
            textAlign: TextAlign.center,
            style: kTitleStyle.copyWith(fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}
