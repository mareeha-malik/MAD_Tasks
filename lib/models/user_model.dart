class User {
  final int? id;
  final String name;
  final String address;
  final String password;

  User({
    this.id,
    required this.name,
    required this.address,
    required this.password,
  });

  // Convert a User into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'password': password,
    };
  }

  // Convert a Map into a User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      name: map['name'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
    );
  }
}