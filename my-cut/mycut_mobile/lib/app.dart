import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes.dart';

class AfroCutApp extends StatelessWidget {
  const AfroCutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AfroCut',
      theme: AppTheme.light,
      initialRoute: Routes.signIn,
      routes: Routes.map,
      debugShowCheckedModeBanner: false,
    );
  }
}



