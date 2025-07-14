import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insurance_seguradora/app/app.dart';
import 'package:insurance_seguradora/core/services/auth_service.dart';
import 'package:insurance_seguradora/domain/viewmodels/session_viewmodel.dart';
import 'package:insurance_seguradora/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService(),),
        ChangeNotifierProvider(create: (_) => SessionViewModel()),
      ],
      child: MyApp(),
    ),
  );
}
