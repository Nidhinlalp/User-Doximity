import 'package:flutter/material.dart';

var kHight30 = const SizedBox(
  height: 30,
);
var kHight20 = const SizedBox(
  height: 20,
);
var kHight10 = const SizedBox(
  height: 10,
);
var kHight50 = const SizedBox(
  height: 50,
);
var kHight150 = const SizedBox(
  height: 150,
);

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

//width and height initialization
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenWidth;
  }

  static get heigthSize {
    return screenHeight;
  }

  //define spacing height

  static const spaceSmall = SizedBox(
    height: 25,
  );
  static final spaceMedium = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final spaceBig = SizedBox(
    height: screenHeight! * 0.08,
  );
}
