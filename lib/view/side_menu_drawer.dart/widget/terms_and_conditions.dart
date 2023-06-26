import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: kBlackColor900,
          ),
        ),
        elevation: 0,
        backgroundColor: kWhiteColor,
        title: Text(
          'Terms And Condition',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Text(
                'App Usage: Our Doctor Booking App allows you to search for and book appointments with doctors listed on the app. The app is intended for personal, non-commercial use only, and you may not use it for any other purpose.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Doctor Listings: The doctors listed on our app are independent healthcare providers and are not employees or agents of the app. We do not guarantee the accuracy or completeness of the information provided by the doctors, including their availability, qualifications, and fees. It is your responsibility to verify the information provided by the doctors before booking an appointment.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Appointment Booking: When you book an appointment through our app, you are entering into a direct relationship with the doctor. The app is not responsible for any issues or disputes that may arise between you and the doctor, including but not limited to appointment cancellations, rescheduling, or changes in fees.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'User Accounts: In order to use our app, you may need to create a user account. You are responsible for maintaining the confidentiality of your account information, including your username and password, and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account or any other breach of security.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'User Conduct: You agree to use our app in a responsible and lawful manner. You will not use the app to post, upload, or transmit any content that is illegal, harmful, offensive, defamatory, or otherwise objectionable. You also agree not to engage in any activity that may interfere with the operation of the app, such as hacking, data mining, or spamming.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Privacy: We take your privacy seriously and will use your personal information in accordance with our Privacy Policy. By using our app, you consent to the collection, use, and disclosure of your personal information as described in our Privacy Policy.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Intellectual Property: Our app and all of its content, including but not limited to text, graphics, logos, images, and software, are the property of the app or its licensors and are protected by intellectual property laws. You may not use, reproduce, modify, distribute, or otherwise exploit any part of our app without our prior written consent.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Modifications: We reserve the right to modify or terminate the app or these terms and conditions at any time, with or without notice. Any changes will be effective immediately upon posting on the app. Your continued use of the app after any.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor800,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
