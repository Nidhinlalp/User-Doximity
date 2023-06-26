import 'package:flutter/material.dart';

class SignUpUsernameTextfield extends StatelessWidget {
  const SignUpUsernameTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        //    controller: emailController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
          //labelText: 'Email..',
          hintText: 'Username..',
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
