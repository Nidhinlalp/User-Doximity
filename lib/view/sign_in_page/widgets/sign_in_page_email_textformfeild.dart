import 'package:flutter/material.dart';

class SingInPageEmailTextFormFeild extends StatelessWidget {
  final String? Function(String?)? validator;
  const SingInPageEmailTextFormFeild({
    super.key,
    required this.validator,
  });

  static TextEditingController emalilControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        validator: validator,
        controller: emalilControler,
        textInputAction: TextInputAction.done,
        //    controller: emailController,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
          filled: true,
          fillColor: Colors.white,
          //labelText: 'Email..',
          hintText: 'Email..',
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
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
