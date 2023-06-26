import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view_model/user_profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CompleteProfile extends StatelessWidget {
  const CompleteProfile({super.key});
  static TextEditingController userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(100),
                      color: kWhiteColor,
                    ),
                    height: 100,
                    width: 100,
                    child: FadeInLeft(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: context.watch<UserProfile>().file != null
                            ? Image.file(
                                context.watch<UserProfile>().file!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                IconlyBold.profile,
                                size: 50,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              kHight50,
              FadeInRight(
                child: TextFormField(
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
                    child: Text(
                      'Submit',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: kWhiteColor),
                    ),
                    onPressed: () {
                      context.read<UserProfile>().addUserProfile(context);
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
