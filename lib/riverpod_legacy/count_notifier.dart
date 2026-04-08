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
