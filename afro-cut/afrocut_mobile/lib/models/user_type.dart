enum UserType {
  client,
  barber,
}

class User {
  final String id;
  final String name;
  final String email;
  final UserType type;
  final String? avatar;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.avatar,
    required this.createdAt,
  });

  bool get isClient => type == UserType.client;
  bool get isBarber => type == UserType.barber;
}
