import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'fake_user_api.dart';
import 'user_model.dart';

/// 这是一个 NotifierProvider 的典型写法：
/// - state: 放 UI 需要的“聚合状态”（loading/data/error/时间戳等）
/// - notifier: 放业务方法（发请求、重试、清理、局部更新等）
final userListProvider = NotifierProvider<UserListNotifier, AsyncValue<List<UserModel>>>(UserListNotifier.new);

class UserListNotifier extends Notifier<AsyncValue<List<UserModel>>> {
  @override
  AsyncValue<List<UserModel>> build() {
    // 默认不自动触发网络请求：更通用，也避免 provider 重建时“意外再次请求”。 需要请求时由外部显式调用 requestData()。
    return const AsyncData([]);
  }

  Future<void> requestData({bool simulateError = false, bool randomError = false}) async {
    try {
      state = const AsyncLoading();
      final users = await FakeUserApi().fetchUsers(simulateError: simulateError, randomError: randomError);

      state = AsyncData(users);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// 示例：清空列表（纯本地状态更新）
  void clear() {
    // const AsyncValue.loading()
    // state = const AsyncValue.data([]);
    state = const AsyncData([]);
  }

  /// 示例：对当前列表数据 在不请求网络的情况下，做局部更新，用例
  void promoteFirstUserLevel() {
    final users = state.asData?.value ?? const <UserModel>[];
    if (users.isEmpty) return;
    final first = users.first;
    final updated = [first.copyWith(level: first.level + 1), ...users.skip(1)];
    state = AsyncData(updated);
  }
}
