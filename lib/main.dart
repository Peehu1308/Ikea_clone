import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ikea/home_screen.dart';

Future<void> main() async
{
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  catch(eMessage)
  {
    print("Error:" +eMessage.toString());

  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ikea App',
      theme: ThemeData(
        
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(),
    );
  }
}


