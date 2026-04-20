class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.level,
  });

  final int id;
  final String name;
  final int level;

  UserModel copyWith({
    int? id,
    String? name,
    int? level,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }
}

