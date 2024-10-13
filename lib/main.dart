import 'package:cooking_companion/pages/prompt_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ikcirqrmdgbxpgbkrcdt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlrY2lycXJtZGdieHBnYmtyY2R0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg3MzY2MDIsImV4cCI6MjA0NDMxMjYwMn0.Jtj4_TF6822gOisvDb2a6T52tMkV9tylOb10GOguz7o',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pantry Pal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: const PromptPage());
  }
}
