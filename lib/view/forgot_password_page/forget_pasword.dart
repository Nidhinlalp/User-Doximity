import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/const/style/style.dart';
import 'package:doximity/view/sign_in_page/widgets/sign_in_page_email_textformfeild.dart';
import 'package:doximity/view/sign_in_page/widgets/sign_page_sethescope_image.dart';
import 'package:doximity/view/sign_in_page/widgets/sing_button.dart';
import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  resetPassword(AuthProvider provider, BuildContext context) async {
    final msg = await provider.restPassword(
      context,
      SingInPageEmailTextFormFeild.emalilControler.text,
    );
    if (msg == '') return;
    {
      if (context.mounted) {
        context.read<AuthProvider>().erorr(msg);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      backgroundColor: kBgcolor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/icons/back-icon.png'),
        ),
        backgroundColor: kBgcolor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                kHight50,
                const SingPageSethesCopeImage(
                  image: 'assets/images/Doctors-ForgetPassword-equipment.png',
                ),
                kHight50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Forget Password',
                            style: kNormalStyle.copyWith(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      kHight10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your email address to get an OTP code\n to reset your password..',
                            style: kNormalStyle.copyWith(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kHight30,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SingInPageEmailTextFormFeild(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some Your Email.....!';
                      }
                      return null;
                    },
                  ),
                ),
                kHight50,
                SingInButton(
                  name: 'Send me email',
                  onPressed: () {
                    resetPassword(authProvider, context);
                  },
                  formKey: _formKey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
