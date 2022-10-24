import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel_management_app/logic/auth/Models/user.dart';
import 'package:hotel_management_app/logic/auth/auth_repository.dart';
import 'package:hotel_management_app/logic/auth/login/login_view.dart';
import 'package:hotel_management_app/logic/home/dashboard/bloc/dashboard_view.dart';
import 'package:hotel_management_app/logic/home/dashboard/repo/dashboard_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<User?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUserStrJson = await prefs.getString('savedUser');
    if (savedUserStrJson == null) return null;
    try {
      User savedUserInstance = User.fromJson(savedUserStrJson);
      return savedUserInstance;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<DashboardRepository>(
          create: (context) => DashboardRepository(),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Hotel Management',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        home: FutureBuilder(
            future: getSavedUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return DashboardView(user: snapshot.data!);
              } else {
                return LoginView();
              }
            }),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
