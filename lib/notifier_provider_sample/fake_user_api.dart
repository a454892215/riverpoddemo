import 'dart:math';

import 'user_model.dart';

/// 模拟一个“网络接口层”
/// - 用 Future.delayed 模拟耗时
/// - 用参数模拟失败/随机失败
class FakeUserApi {
  const FakeUserApi();

  Future<List<UserModel>> fetchUsers({
    Duration delay = const Duration(milliseconds: 800),
    bool simulateError = false,
    bool randomError = false,
    int count = 12,
  }) async {
    await Future.delayed(delay);

    if (simulateError) {
      throw Exception('模拟接口失败(simulateError=true)');
    }
    if (randomError && Random().nextBool()) {
      throw Exception('模拟接口随机失败(randomError=true)');
    }

    return List.generate(
      count,
      (i) => UserModel(
        id: i + 1,
        name: '用户-${i + 1}',
        level: (i % 10) + 1,
      ),
    );
  }
}

