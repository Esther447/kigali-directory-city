import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/listing_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ListingProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kigali City Directory',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        primaryColor: Color(0xFF1D1E33),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFFB300),
          secondary: Color(0xFFFFB300),
          surface: Color(0xFF1D1E33),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0A0E21),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF1D1E33),
          elevation: 4,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1D1E33),
          selectedItemColor: Color(0xFFFFB300),
          unselectedItemColor: Colors.white54,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFFB300),
            foregroundColor: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1D1E33),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user != null && authProvider.user!.emailVerified) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}