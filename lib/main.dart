import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/contoller/Bookcontroller.dart';
import 'package:flutter_application_1/contoller/Login_controller.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/view/Search_Book/Search_Book.dart';
import 'package:flutter_application_1/view/Splash_screen/Splash_screen.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => BookController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      
      home:SplashScreen(),
    );
  }
}
