import 'package:flutter/material.dart';
import 'features/auth/sign_in_screen.dart';
import 'features/auth/sign_up_screen.dart';
import 'features/discover/discover_screen.dart';
import 'features/appointments/appointments_screen.dart';
import 'features/profile/profile_screen.dart';

class Routes {
  static const String signIn = '/';
  static const String signUp = '/signup';
  static const String discover = '/discover';
  static const String appointments = '/appointments';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get map => <String, WidgetBuilder>{
        signIn: (_) => const SignInScreen(),
        signUp: (_) => const SignUpScreen(),
        discover: (_) => const DiscoverScreen(),
        appointments: (_) => const AppointmentsScreen(),
        profile: (_) => const ProfileScreen(),
      };
}



