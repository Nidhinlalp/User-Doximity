import 'package:animate_do/animate_do.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view/const/size/size.dart';
import 'package:doximity/view/home/home_screen.dart';
import 'package:doximity/view/sign_in_page/widgets/sign_page_password_textformfeild.dart';
import 'package:doximity/view/sign_in_page/widgets/sign_up_butto.dart';
import 'package:doximity/view/sign_in_page/widgets/sing_button.dart';
import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../sign_in_page/widgets/sign_in_page_email_textformfeild.dart';
import 'widgets/sign_up_quts.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  signUp(AuthProvider provider, BuildContext context) async {
    final msg = await provider.signUp(
        SingInPageEmailTextFormFeild.emalilControler.text,
        SingInPagePasswordTextFormFeild.passWordControler.text,
        context);
    if (msg == '') return;
    {
      if (context.mounted) {
        context.read<AuthProvider>().erorr(msg);
      }
    }
  }

  googleSignUp(AuthProvider provider, BuildContext context) async {
    final msg = await provider.googleSigUp(context);
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
    return StreamBuilder(
      stream: authProvider.stream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return const LogedInWidget();
        return Scaffold(
          backgroundColor: kBgcolor,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  kHight150,
                  FadeInDown(child: const SignUpPageQuts()),
                  kHight30,
                  // FadeInDown(
                  //   child: SignGoogleButton(
                  //     onPressed: () {
                  //       googleSignUp(authProvider, context);
                  //     },
                  //   ),
                  // ),
                  kHight50,
                  // const SignUpUsernameTextfield(),
                  kHight30,
                  FadeInUp(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: SingInPageEmailTextFormFeild(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        kHight30,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: SingInPagePasswordTextFormFeild(),
                        ),
                        kHight50,
                        SingInButton(
                          name: 'Sign Up',
                          onPressed: () {
                            signUp(authProvider, context);
                          },
                          formKey: _formKey,
                        ),
                        kHight30,
                        const SignUpButton(
                          lastText: 'Have an account?',
                          textButton: 'Log in',
                          isSignUp: false,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
