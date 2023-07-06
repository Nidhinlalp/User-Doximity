import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/view/complete_profile/edite_profile.dart';
import 'package:doximity/view/const/alert_box/alertbx.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/showhistory/2.dart';
import 'package:doximity/view/side_menu_drawer.dart/widget/privacy_policy.dart';
import 'package:doximity/view/side_menu_drawer.dart/widget/terms_and_conditions.dart';
import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/user_profile/user_profile.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.grey.shade400],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, top: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('userProfile')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: kWhiteColor,
                              backgroundImage: NetworkImage(
                                snapshot.data!.data()!['profilePic'] ??
                                    'https://tse1.mm.bing.net/th?id=OIP.Xwquh7b39vo0RocyWVTvuQHaHH&pid=Api&P=0',
                              ),
                            ),
                            kHight20,
                            Text(
                              snapshot.data!.data()!['userName'] ?? 'User Name',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Someting Went Wrong'),
                        );
                      } else {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      }
                    },
                  ),
                  kHight30,
                  _AboutInUser(
                    icon: Icons.person,
                    onpressed: () async {
                      var userName =
                          await context.read<UserProfile>().getUserName();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CompleteProfileEdite(userNames: userName),
                        ),
                      );
                    },
                    text: 'Profile',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      color: kBlackColor900,
                    ),
                  ),
                  kHight10,
                  _AboutInUser(
                      text: 'History',
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => History(),
                            ));
                      },
                      icon: Icons.history_rounded),
                  _AboutInUser(
                    icon: Icons.description_outlined,
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsAndCondition(),
                        ),
                      );
                    },
                    text: 'Terms And conditions',
                  ),
                  _AboutInUser(
                    icon: Icons.privacy_tip_outlined,
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPollycy(),
                        ),
                      );
                    },
                    text: 'Privacy Policy',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      color: kBlackColor900,
                    ),
                  ),
                  kHight150,
                  _AboutInUser(
                    icon: Icons.logout_outlined,
                    onpressed: () {
                      showQuickAlert(context, 'Alert', 'Are You Shower Log Out',
                          () => context.read<AuthProvider>().signOut(context));
                      // context.read<AuthProvider>().signOut(context);
                    },
                    text: 'Log Out',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutInUser extends StatelessWidget {
  const _AboutInUser({
    required this.text,
    required this.onpressed,
    required this.icon,
  });
  final String text;
  final Function onpressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        title: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        leading: Icon(icon),
        onTap: () {
          onpressed();
        },
      ),
    );
  }
}
