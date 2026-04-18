// --- [3. StateNotifierProvider]: 管理可变状态 ---

import 'package:flutter_riverpod/legacy.dart';

/// flutter riverpod legacy 使用示例-第2部分-Notifier和StateNotifierProvider
/// 第一步：定义 Notifier 类
class CounterNotifier extends StateNotifier<int> {
  // 必须在构造函数里初始化 state
  CounterNotifier() : super(0);

  void increment() => state++;
}

/// 01. 第二步：手动声明 StateNotifierProvider 和第一步定义的CounterNotifier管理起来。
/// 02. 泛型第一个是类名，第二个是 state 的类型
final manualCounterProvider = StateNotifierProvider<CounterNotifier, int>((
  ref,
) {
  return CounterNotifier();
});

///flutter 状态管理框架riverpod中 1.StateProvider 2.NotifierProvider  3. StateNotifierProvider 有什么区别
///| 类型                    | 用途      | 是否推荐     | 是否有业务逻辑 | 写法复杂度 |
// | --------------------- | ------- | -------- | ------- | ----- |
// | StateProvider         | 简单状态    | ✔ 小范围用   | ❌ 很少    | ⭐     |
// | NotifierProvider      | 复杂状态（新） | ⭐⭐⭐ 强烈推荐 | ✔ 有     | ⭐⭐    |
// | StateNotifierProvider | 旧复杂状态   | ⚠️ 逐步淘汰  | ✔ 有     | ⭐⭐⭐⭐  |

