import 'package:flutter/material.dart';

class SingInPagePasswordTextFormFeild extends StatelessWidget {
  const SingInPagePasswordTextFormFeild({
    super.key,
  });
  static TextEditingController passWordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Your Password.....!';
          }
          return null;
        },
        controller: passWordControler,
        textInputAction: TextInputAction.done,
        // controller: emailController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
          //labelText: 'Email..',
          hintText: 'Password..',
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
