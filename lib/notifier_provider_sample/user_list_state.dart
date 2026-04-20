import 'user_model.dart';

class UserListState {
  const UserListState({
    required this.isLoading,
    required this.users,
    this.errorMessage,
    this.lastUpdatedAt,
  });

  final bool isLoading;
  final List<UserModel> users;
  final String? errorMessage;
  final DateTime? lastUpdatedAt;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  UserListState copyWith({
    bool? isLoading,
    List<UserModel>? users,
    String? errorMessage,
    DateTime? lastUpdatedAt,
  }) {
    return UserListState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      errorMessage: errorMessage,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  static const empty = UserListState(isLoading: false, users: []);
}

