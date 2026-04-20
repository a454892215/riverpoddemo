import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fake_user_api.dart';
import 'user_model.dart';

/// 这是一个 NotifierProvider 的典型写法：
/// - state: 放 UI 需要的“聚合状态”（loading/data/error/时间戳等）
/// - notifier: 放业务方法（发请求、重试、清理、局部更新等）
final userListProvider =
    NotifierProvider<UserListNotifier, AsyncValue<List<UserModel>>>(
  UserListNotifier.new,
);

class UserListNotifier extends Notifier<AsyncValue<List<UserModel>>> {
  final FakeUserApi _api = const FakeUserApi();

  bool _didFirstFetch = false;

  @override
  AsyncValue<List<UserModel>> build() {
    // build() 必须是同步的，不能直接 await。
    // 但我们可以在首次创建时，用 microtask 触发一次初始化加载。
    if (!_didFirstFetch) {
      _didFirstFetch = true;
      Future.microtask(fetchUsers);
    }
    return const AsyncLoading();
  }

  Future<void> fetchUsers({
    bool simulateError = false,
    bool randomError = false,
  }) async {
    try {
      state = const AsyncLoading();
      final users = await _api.fetchUsers(
        simulateError: simulateError,
        randomError: randomError,
      );

      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 示例：清空列表（纯本地状态更新）
  void clear() {
    state = const AsyncData([]);
  }

  /// 示例：对当前列表做一次“局部更新”（仍然要替换整个 List 才会触发 UI）
  void promoteFirstUserLevel() {
    final users = state.asData?.value ?? const <UserModel>[];
    if (users.isEmpty) return;
    final first = users.first;
    final updated = [
      first.copyWith(level: first.level + 1),
      ...users.skip(1),
    ];
    state = AsyncData(updated);
  }
}
