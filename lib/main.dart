import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/onboarding/presentation/views/onboarding_riverpod_view.dart';

void runProject() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Env.initialize();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experiences APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const OnboardingRiverpodView(),
    );
  }
}

