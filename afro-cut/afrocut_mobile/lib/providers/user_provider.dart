import 'package:flutter/material.dart';
import '../models/user_type.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  UserType _userType = UserType.client; // Default to client

  User? get currentUser => _currentUser;
  UserType get userType => _userType;
  bool get isClient => _userType == UserType.client;
  bool get isBarber => _userType == UserType.barber;

  void setUser(User user) {
    _currentUser = user;
    _userType = user.type;
    notifyListeners();
  }

  void switchUserType(UserType type) {
    _userType = type;
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    _userType = UserType.client;
    notifyListeners();
  }

  // Mock user data for testing
  void loginAsClient() {
    _currentUser = User(
      id: 'client1',
      name: 'John Doe',
      email: 'john@example.com',
      type: UserType.client,
      createdAt: DateTime(2024, 1, 1),
    );
    _userType = UserType.client;
    notifyListeners();
  }

  void loginAsBarber() {
    _currentUser = User(
      id: 'barber1',
      name: 'Marcus Johnson',
      email: 'marcus@elitecuts.com',
      type: UserType.barber,
      createdAt: DateTime(2024, 1, 1),
    );
    _userType = UserType.barber;
    notifyListeners();
  }
}
