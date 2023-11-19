import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thiran_task/cubits/case_one/case_one_cubit.dart';
import 'package:thiran_task/cubits/case_three/case_three_cubit.dart';
import 'package:thiran_task/cubits/case_two/case_two_cubit.dart';
import 'package:thiran_task/views/challenge_three/challenge_three_view.dart';
import 'package:thiran_task/views/challenge_two/challenge_two_view.dart';
import 'package:thiran_task/views/home/home_page.dart';
import 'package:thiran_task/views/splash_screen/splash_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmailCubit(),
        ),
        BlocProvider(
          create: (context) => RepoCubit()..fetchRepos(),
          child: ChallengeTwoView(),
        ),
        BlocProvider(
          create: (context) => TicketCubit("85"),
          child: ChallengeThreeView(userId: "85"),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenView(),
      ),
    );
  }
}
