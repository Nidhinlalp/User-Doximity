import 'package:doximity/view/home/mainhomescreen.dart';
import 'package:doximity/view/welcome/get_start.dart';
import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: context.read<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[500]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(17),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(10, 20),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Someting Want Wrong'));
          } else if (snapshot.hasData) {
            return MainScreen();
          } else {
            return const GetStart();
          }
        },
      ),
    );
  }
}
