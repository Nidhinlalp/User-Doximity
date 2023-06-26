import 'package:doximity/model/doctormodel/doctor_model.dart';
import 'package:doximity/view/const/image/doctormenu/doctor_menu.dart';
import 'package:doximity/view/dr_speciality/dr_spesiality.dart';
import 'package:doximity/view_model/drdetails/dr_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorAppGridCatagory extends StatefulWidget {
  const DoctorAppGridCatagory({super.key});

  @override
  State<DoctorAppGridCatagory> createState() => _DoctorAppGridCatagoryState();
}

class _DoctorAppGridCatagoryState extends State<DoctorAppGridCatagory> {
  List<AllDoctorsDetails> dental = [];

  List<AllDoctorsDetails> cardiology = [];

  List<AllDoctorsDetails> dermatologist = [];

  List<AllDoctorsDetails> surgeon = [];

  List<AllDoctorsDetails> otolaryngologist = [];

  List<AllDoctorsDetails> orthopedic = [];

  List<AllDoctorsDetails> ophthalmologist = [];

  List<AllDoctorsDetails> radiologists = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getAlldoctorStream(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          dental = snapshot.data!
              .where((element) =>
                  element.department == 'Dental' && element.requst == true)
              .toList();
          cardiology = snapshot.data!
              .where((element) =>
                  element.department == 'Cardiology' && element.requst == true)
              .toList();
          dermatologist = snapshot.data!
              .where((element) =>
                  element.department == 'Dermatologist' &&
                  element.requst == true)
              .toList();
          surgeon = snapshot.data!
              .where((element) =>
                  element.department == 'Surgeon' && element.requst == true)
              .toList();
          otolaryngologist = snapshot.data!
              .where((element) =>
                  element.department == 'Otolaryngologist' &&
                  element.requst == true)
              .toList();
          orthopedic = snapshot.data!
              .where((element) =>
                  element.department == 'Orthopedic' && element.requst == true)
              .toList();
          ophthalmologist = snapshot.data!
              .where((element) =>
                  element.department == 'Ophthalmologist' &&
                  element.requst == true)
              .toList();
          radiologists = snapshot.data!
              .where((element) =>
                  element.department == 'Radiologists' &&
                  element.requst == true)
              .toList();

          List<List<AllDoctorsDetails>> allCategories = [];
          allCategories.addAll([
            dental,
            cardiology,
            dermatologist,
            surgeon,
            otolaryngologist,
            orthopedic,
            ophthalmologist,
            radiologists
          ]);
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 0,
            ),
            padding: EdgeInsets.zero,
            itemCount: doctorMenu.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrSpacialityPage(
                        specificDoctor: allCategories[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 81,
                    maxWidth: 81,
                  ),
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 56,
                          minWidth: 56,
                          maxWidth: 70,
                          maxHeight: 69,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/icons/${doctorMenu[index].image}',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Expanded(
                        child: Text(
                          doctorMenu[index].neme,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
