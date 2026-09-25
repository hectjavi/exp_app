import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firebase_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';
import 'package:flutter_application_1/core/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
 if (!kIsWeb) {

   await FirebaseAuth.instance.useAuthEmulator(
     '10.0.2.2',
     9099,
   );

   FirebaseFirestore.instance.useFirestoreEmulator(
     '10.0.2.2',
     8080,
   );

 } else {

   await FirebaseAuth.instance.useAuthEmulator(
     'localhost',
     9099,
   );

   FirebaseFirestore.instance.useFirestoreEmulator(
     'localhost',
     8080,
   );
 }

  // final notificationService = FirebaseNotificationService();
  // await notificationService.initialize();
await FirebaseAuth.instance.signOut();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Experiences APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}
