import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/side_menu_drawer.dart/side_drawer.dart';
import 'package:doximity/view/view_all_doctors/view_all_doctors.dart';
import 'package:flutter/material.dart';

import '../side_menu_drawer.dart/widget/drawerlist.dart';
import 'wdgets/doctor_grid_catagory.dart';
import 'wdgets/home_screen_navbar.dart';
import 'wdgets/top_doctors_list.dart';

class LogedInWidget extends StatelessWidget {
  const LogedInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          color: kGreenLightColor,
          child: const DrawerList(),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bounce(child: const HomeScreenNavbar()),
                  kHight10,
                  FadeInLeft(
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.displayLarge,
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Find',
                          ),
                          TextSpan(
                            text: '  Your Doctor',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: kGrayColor900),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // kHight30,
                  // const SearchFeildInHome(),
                  kHight20,
                  ElasticIn(child: const DoctorAppGridCatagory()),
                  kHight30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SlideInLeft(
                        child: Text(
                          'Top Doctors',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewAllDoctors(),
                            ),
                          );
                        },
                        child: SlideInRight(
                          child: Text(
                            'View all',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: kBlueColor,
                                  fontSize: 15,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHight20,
                  SlideInDown(child: const TopDoctorsList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
