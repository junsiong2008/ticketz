import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/auth_wrapper.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/auth_state_provider.dart';
import 'package:ticketz/providers/excel_provider.dart';
import 'package:ticketz/providers/qr_state_provider.dart';
import 'package:ticketz/providers/search_provider.dart';
import 'package:ticketz/services/firestore.dart';
import 'package:ticketz/shared/constants.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticketz',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
