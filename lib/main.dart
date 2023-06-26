import 'package:doximity/firebase_options.dart';
import 'package:doximity/view/const/doctorapptheme/doctor_app_theme.dart';
import 'package:doximity/view_model/authprovider/auth.dart';
import 'package:doximity/view_model/booking/booking_dr.dart';
import 'package:doximity/view_model/favorite/favorite.dart';
import 'package:doximity/view_model/feedback/feedback.dart';
import 'package:doximity/view_model/home/home_bottom_nav.dart';
import 'package:doximity/view_model/network_error_handling/network_error_handling.dart';
import 'package:doximity/view_model/search/search.dart';
import 'package:doximity/view_model/user_profile/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// ...
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(FirebaseAuth.instance),
          child: StreamProvider(
            create: (context) => context.watch<AuthProvider>().stream(),
            initialData: null,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BotomNav(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavorteDr(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProfile(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedbackProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Search(),
        )
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: DoctorAppTheme.lightTheme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
