class User {
  String email;

  User({required this.email});

  Map<String, dynamic> toJson() => {
    'email': email,
  };
}