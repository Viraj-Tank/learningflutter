import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learningflutter/ui/NotesPage.dart';
import 'package:learningflutter/ui/SplashPage.dart';

/*void main() {
  runApp(
    const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: true,
    ),
  );
}*/

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = '2Do List';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
    home: const SplashPage(),
  );
}