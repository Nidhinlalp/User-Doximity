import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedButton(
          bgColor: kWhiteColor,
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          iconColor: kBlackColor900,
          tap: () => Navigator.pop(context),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          'On you FeedBack',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 24,
                color: kWhiteColor,
              ),
        )
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.tap,
  });
  final Icon icon;
  final Color iconColor, bgColor;
  final GestureTapCallback tap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: bgColor,
      ),
      child: IconButton(
        onPressed: tap,
        icon: icon,
        color: iconColor,
      ),
    );
  }
}
