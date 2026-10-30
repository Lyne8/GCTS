import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/dashboard_screen.dart';

// main() is where every Dart program starts.
void main() => runApp(
      // ProviderScope is required by Riverpod.
      // It holds all the providers for the whole app.
      const ProviderScope(child: GctsApp()),
    );

// The root widget of the app. It doesn't change, so it's "Stateless".
class GctsApp extends StatelessWidget {
  const GctsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'GCTS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
        ),
        home:  DashboardScreen(),
      );
}