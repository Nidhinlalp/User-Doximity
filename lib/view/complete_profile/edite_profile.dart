// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view_model/user_profile/user_profile.dart';

class CompleteProfileEdite extends StatelessWidget {
  final String userNames;
  const CompleteProfileEdite({
    Key? key,
    required this.userNames,
  }) : super(key: key);

  static TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(userNames.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: kBlackColor900,
          ),
        ),
        backgroundColor: kWhiteColor,
        centerTitle: true,
        title: BounceInDown(
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: [
              kHight20,
              CupertinoButton(
                onPressed: () {
                  context.read<UserProfile>().pickFile();
                },
                child: FadeInDown(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kWhiteColor,
                      border: Border.all(),
                    ),
                    child: FadeInLeft(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: context.watch<UserProfile>().file != null
                              ? Image.file(
                                  context.watch<UserProfile>().file!,
                                  fit: BoxFit.cover,
                                )
                              : FutureBuilder(
                                  future:
                                      context.read<UserProfile>().getProfile(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: Text('Loading....,'),
                                      );
                                    }
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        snapshot.data!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  })),
                    ),
                  ),
                ),
              ),
              kHight50,
              FadeInRight(
                child: TextFormField(
                  initialValue: userNames,
                  // validator: validator,
                  controller: userName,
                  textInputAction: TextInputAction.done,
                  //    controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 17.0, horizontal: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    //labelText: 'Email..',
                    hintText: 'Enter Your Name..',
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(17),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              kHight50,
              FadeInLeft(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CupertinoButton(
                    child: context.watch<UserProfile>().isProfileUpdateLoding
                        ? const CupertinoActivityIndicator()
                        : Text(
                            'Save',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: kWhiteColor),
                          ),
                    onPressed: () {
                      context.read<UserProfile>().editeUserProfile(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
