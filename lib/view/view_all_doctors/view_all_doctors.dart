import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/home/wdgets/search_textfeild.dart';
import 'package:doximity/view/home/wdgets/top_doctors_list.dart';
import 'package:flutter/material.dart';

class ViewAllDoctors extends StatelessWidget {
  const ViewAllDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Doctors',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kBlackColor900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
          child: Column(
            children: [
              kHight10,
              FadeInLeft(child: const SearchFeildInHome()),
              kHight30,
              FadeInRight(child: const TopDoctorsList()),
            ],
          ),
        ),
      ),
    );
  }
}
