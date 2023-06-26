import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doximity/view/booking_page/widgets/booking_patients_datas.dart';
import 'package:doximity/view/const/color/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingProvider with ChangeNotifier {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? currentIndex;
  bool isWeekend = false;
  bool dateSelected = false;
  bool timeSelected = false;
  String? time;

  set setCurrentIndex(int? index) {
    currentIndex = index;

    notifyListeners();
  }

  set setTimeSelected(bool selected) {
    timeSelected = selected;
    notifyListeners();
  }

  set selectedTime(String times) {
    time = times;
    notifyListeners();
    log(time.toString());
  }

  Widget tableCalender() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: kGreenColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      onFormatChanged: (format) {
        _format = format;
        notifyListeners();
      },
      onDaySelected: (selectedDay, focusedDay) {
        _currentDay = selectedDay;
        _focusDay = focusedDay;
        log(_currentDay.toString());
        dateSelected = true;
        // chek weekend is selected
        if (selectedDay.weekday == 6 || selectedDay.weekday == 7) {
          isWeekend = true;
          timeSelected = false;
          currentIndex = null;
        } else {
          isWeekend = false;
        }
        notifyListeners();
      },
    );
  }

  late bool isloding = false;
  var doctors = FirebaseFirestore.instance.collection('doctors');
  var patint = FirebaseFirestore.instance.collection('patient');

  Future booking(docroId, context, profilePic, department, drname) async {
    isloding = true;
    notifyListeners();

    log(time.toString());
    var bookingData = {
      'patientName': BookingPatientDates.patientName.text,
      'patientAge': BookingPatientDates.patientAge.text,
      'patientPhomeNumber': BookingPatientDates.patientPhomeNumber.text,
      'date': _currentDay.toString(),
      'time': time,
      'acept': false,
      'decline': false,
      'completed': false,
      'descrption': BookingPatientDates.patientDescription.text,
      'userUid': FirebaseAuth.instance.currentUser!.uid,
      'profilePic': profilePic,
      'department': department,
      'drname': drname
    };
    var docRef = doctors
        .doc(docroId)
        .collection("patient")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var pRef = doctors
        .doc(docroId)
        .collection("patientLisernDr")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    doctors.doc(docroId).set(
      {
        'appliedPatients': [FirebaseAuth.instance.currentUser!.uid]
      },
      SetOptions(merge: true),
    );

    await docRef.set(bookingData);
    await pRef.set(bookingData);
    isloding = false;
    clear();
    notifyListeners();
  }

  clear() {
    BookingPatientDates.patientName.clear();
    BookingPatientDates.patientAge.clear();
    BookingPatientDates.patientPhomeNumber.clear();
    BookingPatientDates.patientDescription.clear();
  }

  Future<void> decline(docroId) async {
    final acepted = {
      'acept': false,
      'decline': true,
    };
    final ref = FirebaseFirestore.instance
        .collection('doctors')
        .doc(docroId)
        .collection('patient')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final refDr = FirebaseFirestore.instance
        .collection('doctors')
        .doc(docroId)
        .collection('patient')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await ref.update(acepted);
    await refDr.update(acepted);
    notifyListeners();
  }
}
