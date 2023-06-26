import 'package:doximity/view/const/size/size.dart';
import 'package:flutter/material.dart';

class BookingPatientDates extends StatelessWidget {
  const BookingPatientDates({
    super.key,
    required this.formKey,
  });

  static TextEditingController patientName = TextEditingController();
  static TextEditingController patientAge = TextEditingController();
  static TextEditingController patientPhomeNumber = TextEditingController();
  static TextEditingController patientDescription = TextEditingController();

  final GlobalKey formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          kHight30,
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Name';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            controller: patientName,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Patient Name..',
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
            keyboardType: TextInputType.name,
          ),
          kHight20,
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Age';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            controller: patientAge,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Patient Age..',
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
            keyboardType: TextInputType.number,
          ),
          kHight20,
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Phone Number';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            controller: patientPhomeNumber,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Patient or Guardiane Phone Number..',
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
            keyboardType: TextInputType.phone,
          ),
          kHight20,
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Your Descrption';
              }
              return null;
            },
            maxLines: null,
            minLines: null,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            controller: patientDescription,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Please enter Your Descrption...',
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
        ],
      ),
    );
  }
}
