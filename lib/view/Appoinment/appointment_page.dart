import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/Appoinment/widget/first_tab.dart';
import 'package:doximity/view/Appoinment/widget/second_tab.dart';
import 'package:doximity/view/Appoinment/widget/third_tab.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:flutter/material.dart';

class AppointMentPage extends StatelessWidget {
  const AppointMentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          elevation: 0,
          centerTitle: true,
          title: BounceInDown(
            child: Text(
              'Appointment Schedule',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        body: const Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.upcoming_rounded,
                    color: kBlackColor900,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.compare_outlined,
                    color: kBlackColor900,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.cancel_schedule_send_outlined,
                    color: kBlackColor900,
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FirstTab(),
                  SecondTab(),
                  ThirdTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
