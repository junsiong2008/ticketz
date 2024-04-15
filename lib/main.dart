import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/secrets/secrets.dart';
import 'package:ticketz/auth_wrapper.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/providers/excel_provider.dart';
import 'package:ticketz/providers/qr_state_provider.dart';
import 'package:ticketz/providers/registration_form_provider.dart';
import 'package:ticketz/providers/registration_state_provider.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/services/firestore.dart';
import 'package:ticketz/shared/constants.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (!kIsWeb) {
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }

    // Firebase App Check
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider(webRecaptchaSiteKey),
    );

    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

    final firestoreService = FirestoreService();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthStateProvider(),
          ),
          StreamProvider<List<Participant>>.value(
            value: firestoreService.participantStream(),
            initialData: const <Participant>[],
          ),
          ChangeNotifierProvider(
            create: ((context) => QRStateProvider()),
          ),
          ChangeNotifierProvider(
            create: (context) => ExcelProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegistrationStateProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegistrationFormProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketz',
      theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
          )),
      home: const AuthWrapper(),
    );
  }
}
