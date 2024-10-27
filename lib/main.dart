import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pantry_pal/pages/prompt_page.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ikcirqrmdgbxpgbkrcdt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlrY2lycXJtZGdieHBnYmtyY2R0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg3MzY2MDIsImV4cCI6MjA0NDMxMjYwMn0.Jtj4_TF6822gOisvDb2a6T52tMkV9tylOb10GOguz7o',
  );

//Google Fonts licenses
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
      color: Colors.yellow[50],
      home: PromptPage(),
    );
  }
}


//--------------------- TEST
/*
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LinkedPhysicsApp());
}

class BasicUsageApp extends StatelessWidget {
  const BasicUsageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: DynMouseScroll(
              builder: (context, controller, physics) => ListView(
                    controller: controller,
                    physics: physics,
                    children: List.generate(
                        40,
                        (index) => Container(
                            height: 500,
                            color: (index % 2 == 0)
                                ? Colors.redAccent
                                : Colors.blueAccent)),
                  ))),
    );
  }
}

class CustomSettingsUsageApp extends StatelessWidget {
  const CustomSettingsUsageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: DynMouseScroll(
              durationMS: 500,
              scrollSpeed: 4.4,
              animationCurve: Curves.easeOutQuart,
              builder: (context, controller, physics) => ListView(
                    controller: controller,
                    physics: physics,
                    children: List.generate(
                        40,
                        (index) => Container(
                            height: 500,
                            color: (index % 2 == 0)
                                ? Colors.redAccent
                                : Colors.blueAccent)),
                  ))),
    );
  }
}

class LinkedPhysicsApp extends StatelessWidget {
  const LinkedPhysicsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: Column(children: [
      Expanded(
          child: Row(children: const [
        MyScrollingWidget(height: 100, colors: [Colors.blue, Colors.red]),
        MyScrollingWidget(height: 200, colors: [Colors.yellow, Colors.green]),
      ])),
      Expanded(
          child: Row(children: const [
        MyScrollingWidget(height: 150, colors: [Colors.purple, Colors.orange]),
        MyScrollingWidget(height: 80, colors: [Colors.black, Colors.white])
      ]))
    ]))));
  }
}

class MyScrollingWidget extends StatelessWidget {
  final List<Color> colors;
  final double height;
  const MyScrollingWidget(
      {Key? key, required this.colors, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DynMouseScroll(
            //hasParentListener: true,
            builder: (context, controller, physics) => ListView(
                  controller: controller,
                  physics: physics,
                  children: List.generate(
                      50,
                      (index) => Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: height,
                          color: (index % 2 == 0) ? colors[0] : colors[1])),
                )));
  }
}
*/