import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPollycy extends StatelessWidget {
  const PrivacyPollycy({super.key});

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
          'Privacy Polycy',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Information We Collect',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              kHight20,
              Text(
                'Personal Information You Provide: When you register an account on the App, you may be asked to provide personal information such as your name, email address, phone number, and other relevant information.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Health Information: In order to book appointments with doctors through the App, you may choose to provide health-related information, such as your medical history, symptoms, and other relevant health details.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'App Usage Information: We may automatically collect certain information about your use of the App, such as your IP address, device information, and usage patterns. This information is used to improve the performance and functionality of the App.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Data Security',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              kHight20,
              Text(
                'We take reasonable measures to protect the security of your personal information and strive to keep it confidential and secure. However, please be aware that no security measures are perfect or completely foolproof, and we cannot guarantee the absolute security of your personal information.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Information Sharing',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
              kHight20,
              Text(
                'Service Providers: We may share your personal information with third-party service providers who help us operate the App and provide services to you, such as hosting, data storage, payment processing, and customer support.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Doctors and Healthcare Providers: We may share your personal information with doctors and healthcare providers whose services you book through the App, in order to facilitate your appointments and provide quality healthcare services.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
                      fontFamily: GoogleFonts.sourceSansPro().fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                overflow: TextOverflow.ellipsis,
                maxLines: 100,
              ),
              kHight20,
              Text(
                'Doctors and Healthcare Providers: We may share your personal information with doctors and healthcare providers whose services you book through the App, in order to facilitate your appointments and provide quality healthcare services.',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: kBlackColor900,
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
